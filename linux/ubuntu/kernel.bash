#!/usr/bin/env bash

#@ Install Ubuntu mainline kernel 
[ -f /etc/apt/sources.list.d/cappelikan.sources ] && \
  ( [[ ! -x "$(command -v mainline)" ]] && install mainline )

mainline check