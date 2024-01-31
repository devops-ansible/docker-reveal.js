#!/usr/bin/env bash

set -ex

apt-get update
apt-get upgrade -y
apt-get install -y jq vim

latest_info=$( curl https://api.github.com/repos/hakimel/reveal.js/releases/latest 2>/dev/null )
extract_dir="${WORKINGDIR}"

chmod a+x ./entrypoint.sh
tarball=$( echo "${latest_info}" | jq -r '.tarball_url' )
mkdir "${extract_dir}"
curl -s -L "${tarball}" | tar -oxzvf - -C "${extract_dir}" --strip-components 1
cd "${extract_dir}"
npm install -g npm
npm install
cd /
rm -f "$( readlink -f "$0" )"
