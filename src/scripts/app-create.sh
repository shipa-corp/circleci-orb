#!/bin/bash
set -x
# scripts/app-create.sh
AppCreate () {

    if ! [ -x "$(command -v shipa-ci)" ]; then
	echo "Installing shipa-ci tool"
	pip install -v shipa-ci==v0.10.12
    fi

    if [ -z "${SHIPA_CA}" ]; then
	shipa-ci \
	    --server="${SHIPA_SERVER}" \
	    --email="${SHIPA_USER}" \
	    --password="${SHIPA_PASSWORD}" \
	    --insecure \
	    app create "${SHIPA_APP_NAME}" "${SHIPA_APP_PLATFORM}" \
	    --team="${SHIPA_TEAM}" \
	    --framework="${SHIPA_FRAMEWORK}"
    else
	shipa-ci \
	    --server="${SHIPA_SERVER}" \
	    --email="${SHIPA_USER}" \
	    --password="${SHIPA_PASSWORD}" \
	    --ca="$(echo "${SHIPA_CA}" | base64 -d)" \
	    app create "${SHIPA_APP_NAME}" "${SHIPA_APP_PLATFORM}" \
	    --team="${SHIPA_TEAM}" \
	    --framework="${SHIPA_FRAMEWORK}"
	
    fi

}

# We want to eat the error if the app has already been created
AppCreate || true 
