#!/bin/bash

[[ ! -x "$(command -v dialog)" ]] && install dialog

function main_menu() 
{
  cmd=(dialog --separate-output --checklist "Select options:" 20 50 10)
  options=(
    1 "Brave           " off
    2 "Chromium        " off
    3 "Google Chrome   " off
    4 "Microsoft Edge  " off
    5 "Mozilla Firefox " off
    6 "Tor Browser     " off
    7 "Opera           " off
    8 "Vivaldi         " off
    9 "Yandex          " off
    x "Exit            " off
  )

  choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

  for choice in $choices; do
    case $choice in
      1) echo "Brave"    ;;
      2) echo "Chromium" ;;
      3) echo "Chrome"   ;;
      4) echo "Edge"     ;;
      5) echo "Firefox"  ;;
      6) echo "Tor"      ;;
      7) echo "Opera"    ;;
      8) echo "Vivaldi"  ;;
      9) echo "Yandex"   ;;
      x) break            ;;
    esac
  done
}

main_menu



function browser()
{
sudo \cat <<-EOF >>/etc/apt/sources.list.d/browser.sources 
#! text
EOF
}



#!/bin/bash

function main_menu() 
{
  cmd=(dialog --title "Repositories list" --notags --separate-output --checklist "Select items:" 20 50 10)
  options=(
    1 "Brave           " off
    2 "Chromium        " off
    3 "Google Chrome   " off
    4 "Microsoft Edge  " off
    5 "Mozilla Firefox " off
    6 "Tor Browser     " off
    7 "Opera           " off
    8 "Vivaldi         " off
    9 "Yandex          " off
    x "Exit            " off
  )

  choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

  for choice in $choices; 
    do
      case $choice in
        "Brave           ") echo "Brave" ;;
        "Chromium        ") echo "Chromium" ;;
        "Google Chrome   ") echo "Google Chrome" ;;
        "Microsoft Edge  ") echo "Microsoft Edge" ;;
        "Mozilla Firefox ") echo "Mozilla Firefox" ;;
        "Tor Browser     ") echo "Tor Browser" ;;
        "Opera           ") echo "Opera" ;;
        "Vivaldi         ") echo "Vivaldi" ;;
        "Yandex          ") echo "Yandex" ;;
        "Exit            ") break ;;
        *) echo "Invalid selection: $choice" ;;
      esac
    done

  echo "You selected: $choices"
}

main_menu
