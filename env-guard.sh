#!/bin/bash

errors=()

warnings=()

# Rules goes after this line

#url_regex='(.+)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
number_regex='^[0-9]+$'

#if ! [[ $DOMAIN =~ $url_regex ]]; then
#  errors=("${errors[@]}" "DOMAIN env var is not a URL")
#fi

if [ -z "${DOMAIN}" ]; then
  errors=("${errors[@]}" "DOMAIN env var is undefined")
fi

if [ -z "${SECRET}" ]; then
  errors=("${errors[@]}" "SECRET env var is undefined")
fi

if [ -z "${KEY}" ]; then
  errors=("${errors[@]}" "KEY env var is undefined")
fi

if [ -z "${TTL}" ];
  then
    errors=("${errors[@]}" "TTL env var is undefined")
  else
    if ! [[ "${TTL}" =~ $number_regex ]];
      then
        errors=("${errors[@]}" "TTL env var is not a number")
      else
        if [ "${TTL}" -le 0 ]; then
          errors=("${errors[@]}" "TTL env var should be greater than 0")
        fi
    fi
fi

# Do not edit after this line

if [ ${#warnings[@]} -ne 0 ]; then
    printf 'Warning: %s\n' "${warnings[@]}"
fi

if [ ${#errors[@]} -ne 0 ]; then
    printf 'Error: %s\n' "${errors[@]}"
    exit 1
fi