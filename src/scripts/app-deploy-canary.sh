#!/bin/bash

set -x

# scripts/app-deploy-canary.sh
AppDeployCanary () {

    if ! [ -x "$(command -v shipa-ci)" ]; then
	echo "Installing shipa-ci tool"
	pip install -v shipa-ci==v0.10.12
    fi

    if [[ -z "${SHIPA_CA}" ]]; then
	shipa-ci --server="${SHIPA_SERVER}" \
		 --email="${SHIPA_USER}" \
		 --password="${SHIPA_PASSWORD}" \
		 --insecure \
		 app deploy --app "${SHIPA_APP_NAME}" \
		 --directory="${SHIPA_SOURCE_DIRECTORY}" \
		 --steps="${SHIPA_CANARY_STEPS}" \
		 --step-interval="${SHIPA_CANARY_INTERVAL}" \
		 --step-weight="${SHIPA_CANARY_STEP_WEIGHT}"
    else
	shipa-ci --server="${SHIPA_SERVER}" \
		 --email="${SHIPA_USER}" \
		 --password="${SHIPA_PASSWORD}" \
		 --ca="$(echo "${SHIPA_CA}" | base64 -d)" \
		 app deploy --app "${SHIPA_APP_NAME}" \
		 --directory="${SHIPA_SOURCE_DIRECTORY}" \
		 --steps="${SHIPA_CANARY_STEPS}" \
		 --step-interval="${SHIPA_CANARY_INTERVAL}" \
		 --step-weight="${SHIPA_CANARY_STEP_WEIGHT}"
    fi

}

AppDeployCanary 
