#!/usr/bin/env sh

set -e

if [ "${KEEP_DEFAULTS}" != "true" ]; then
    list_of_files="$( echo '["index.html","demo.html",".gitignore",".github",".npmignore","package.json","package-lock.json","test","examples"]' | jq -r '.[]' )"
    mount_result="$( mount )"
    for item in `echo "${list_of_files}"`; do
        check_file="$( pwd )/${item}"
        if ! { echo "${mount_result}" | grep "on ${check_file} type" 1>/dev/null 2>&1; } then
            rm -rf "${check_file}"
        fi
    done
fi

if [ "${1}" = "start" ]; then
    npm start -- --port=8000 --host=0.0.0.0
else
    exec "$@"
fi
