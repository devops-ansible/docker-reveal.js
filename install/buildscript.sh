#!/usr/bin/env bash

set -ex

apt-get update
apt-get upgrade -y
apt-get install -y jq vim

latest_info=$( curl https://api.github.com/repos/hakimel/reveal.js/releases/latest 2>/dev/null )
version_tag=$( echo "${latest_info}" | jq -r '.tag_name')
built_file="./built.json"
extract_dir="${WORKINGDIR}"

if [ ! -f "${built_file}" ]; then
	touch "${built_file}"
	echo "[]" > "${built_file}"
fi

if { jq -e --arg t "${version_tag}" '. | index($t)' < "${built_file}"; } then
	>&2 echo "Version ${version_tag} already built!"
	exit 1
else
	>&2 echo "Version >>${version_tag}<< will be built"
	chmod a+x ./entrypoint.sh
	tarball=$( echo "${latest_info}" | jq -r '.tarball_url' )
	mkdir "${extract_dir}"
	curl -s -L "${tarball}" | tar -oxzvf - -C "${extract_dir}" --strip-components 1
	cd "${extract_dir}"
	npm install -g npm
	npm install
    cd /
    rm -f "$( readlink -f "$0" )"
fi

