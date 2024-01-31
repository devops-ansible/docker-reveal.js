#!/usr/bin/env bash

set -ex

apt-get update
apt-get upgrade -y
apt-get install -y jq vim

latest_info=$( curl https://api.github.com/repos/hakimel/reveal.js/releases/latest 2>/dev/null )
version_tag=$( echo "${latest_info}" | jq -r '.tag_name')
built_file="./built.json"
extract_dir="/reveal.js"

if [ ! -f "${built_file}" ]; then
	touch "${built_file}"
	echo "[]" > "${built_file}"
fi

if { cat "${built_file}" | jq -e --arg t "${version_tag}" '. | index($t)'; } then
	>&2 echo "Version ${version_tag} already built!"
	exit 1
else
	>&2 echo "Version ${version_tag} will be built"
	tarball=$( echo "${latest_info}" | jq -r '.tarball_url' )
	mkdir "${extract_dir}"
	curl -s -L "${tarball}" | tar -oxzvf - -C "${extract_dir}" --strip-components 1
    cur_dir="$( pwd )"
	cd "${extract_dir}"
	npm install -g npm
	npm install
    cd /
    echo "VERSION BUILT: ${version_tag}"
    cat <<'EOF' > /usr/local/bin/entrypoint
#!/usr/bin/env sh

set -e

if [ "${1}" = "start" ]; then
    npm start -- --port=8000 --host=0.0.0.0
else
    exec "$@"
fi
EOF
    chmod a+x /usr/local/bin/entrypoint
    rm -f "$( readlink -f "$0" )"
fi

