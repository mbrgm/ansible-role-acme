#!/bin/bash
set -eou pipefail
IFS=$'\n\t'

cert=$1
alt_names_comma_separated=$(openssl x509 -noout -text -in "${cert}" \
                                | awk '/X509v3 Subject Alternative Name:/{getline; print}' \
                                | sed 's/DNS://g;')

IFS=', ' read -r -a alt_names <<< "${alt_names_comma_separated}"

for n in "${alt_names[@]}"; do
    echo "$n"
done | sort -u

