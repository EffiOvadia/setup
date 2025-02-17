#!/usr/bin/env bash

[[ ! -x "$(command -v sudo)" ]] && apt install --assume-yes sudo

( id -u effio >& /dev/null ) && ( groups effio | grep -q -w sudo ) || usermod -aG sudo effio
