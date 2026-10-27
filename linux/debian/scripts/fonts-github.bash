#!/usr/bin/env bash
set -euo pipefail

# Font name | GitHub latest-release API URL | ZIP filename regex | Optional font filename glob
FONTS=(
    'iosevka|https://api.github.com/repos/be5invis/Iosevka/releases/latest|^PkgTTF-Iosevka-[0-9.]+\.zip$'
    'source-code-pro|https://api.github.com/repos/adobe-fonts/source-code-pro/releases/latest|(?i)^TTF[-_].*\.zip$'
    'cascadia|https://api.github.com/repos/microsoft/cascadia-code/releases/latest|^CascadiaCode-[0-9.]+\.zip$|*NF*.ttf'
      )

FONT_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/fonts/github"

die() { printf 'Error: %s\n' "$*" >&2; exit 1; }

(( EUID != 0 )) || die 'Run this script as your regular user, without sudo.'
[[ "$FONT_ROOT" == /* ]] || die 'XDG_DATA_HOME must be an absolute path.'
for command in curl jq unzip zipinfo fc-cache sha256sum find install cp; do
    command -v "$command" >/dev/null || die "Required command not found: $command"
done

TEMP_DIR=$(mktemp -d)
trap 'rm -rf -- "$TEMP_DIR"' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

install_font() {
    local name="$1" api_url="$2" asset_regex="$3" font_glob="${4:-}"
    local workspace="$TEMP_DIR/$1" destination="$FONT_ROOT/$1"
    local asset download_url digest actual member
    local -a fonts=() extract_patterns=('*.ttf' '*.otf' '*.ttc')
    [[ -z "$font_glob" ]] || extract_patterns=("$font_glob")

    [[ "$name" =~ ^[A-Za-z0-9][A-Za-z0-9._-]*$ ]] || die "Invalid font directory name: $name"
    [[ "$api_url" =~ ^https://api\.github\.com/repos/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+/releases/latest/?$ ]] || die "Invalid release URL: $api_url"
    mkdir -p "$workspace/extracted"
    printf '\nChecking latest release of %s...\n' "$name"

    curl --fail --silent --show-error --location --retry 3 --connect-timeout 20 \
        --proto '=https' --proto-redir '=https' \
        "$api_url" --output "$workspace/release.json"

    asset=$(jq -cer --arg pattern "$asset_regex" '
        [.assets[] | select(.name | test("\\.zip$"; "i"))] as $zips
        | [$zips[] | select(.name | test($pattern))] as $matches
        | if ($matches | length) == 1 then $matches[0]
          else error("Expected one matching ZIP. Available ZIPs: " + ($zips | map(.name) | join(", ")))
          end
    ' "$workspace/release.json")

    download_url=$(jq -er '.browser_download_url' <<< "$asset")
    digest=$(jq -r '.digest // empty' <<< "$asset")
    [[ "$download_url" == https://github.com/* ]] || die "Unexpected download URL: $download_url"
    printf 'Downloading %s\n' "$(jq -r '.name' <<< "$asset")"

    curl --fail --location --show-error --retry 3 --connect-timeout 20 \
        --proto '=https' --proto-redir '=https' \
        "$download_url" --output "$workspace/font.zip"

    if [[ "$digest" == sha256:* ]]; then
        actual=$(sha256sum "$workspace/font.zip")
        [[ "${actual%% *}" == "${digest#sha256:}" ]] || die "Checksum mismatch for $name"
    fi

    # Reject paths that could escape the extraction directory.
    zipinfo -1 "$workspace/font.zip" > "$workspace/members.txt"
    while IFS= read -r member || [[ -n "$member" ]]; do
        case "$member" in /*|*\\*|../*|*/../*|*/..) die "Unsafe ZIP path: $member" ;; esac
    done < "$workspace/members.txt"

    # Extract only desktop fonts, keeping subdirectories to avoid filename collisions.
    unzip -q -C "$workspace/font.zip" "${extract_patterns[@]}" \
        -d "$workspace/extracted" 2> "$workspace/unzip.log" || {
        # unzip returns 11 when some requested patterns have no matches.
        local status=$?
        if (( status != 11 )); then cat "$workspace/unzip.log" >&2; die "Could not extract $name"; fi
    }

    find "$workspace/extracted" -type l -print -quit > "$workspace/symlinks.txt"
    [[ ! -s "$workspace/symlinks.txt" ]] || die "Unexpected symbolic link in $name archive"

    find "$workspace/extracted" -type f \( -iname '*.ttf' -o -iname '*.otf' -o -iname '*.ttc' \) -print0 > "$workspace/fonts.txt"
    mapfile -d '' -t fonts < "$workspace/fonts.txt"
    ((${#fonts[@]})) || die "No TTF, OTF, or TTC fonts found for $name"

    # Normalize permissions before copying into the user's font directory.
    find "$workspace/extracted" -type d -exec chmod 0755 {} +
    find "$workspace/extracted" -type f -exec chmod 0644 {} +
    install -d -m 0755 "$destination"
    cp -R -- "$workspace/extracted/." "$destination/"
    printf 'Installed %s font files into %s\n' "${#fonts[@]}" "$destination"
}

for font in "${FONTS[@]}"; do
    IFS='|' read -r name api_url asset_regex font_glob <<< "$font"
    install_font "$name" "$api_url" "$asset_regex" "$font_glob"
done

printf '\nUpdating your font cache...\n'
fc-cache -f "$FONT_ROOT"
printf '\nDone. Restart your terminal or font picker to see the new fonts.\n'
