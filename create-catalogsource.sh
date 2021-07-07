#!/bin/bash

# CatalogSource imagePullPolicy is IfNotPresent and can't be changed
# https://github.com/operator-framework/operator-lifecycle-manager/issues/903
# The image will not get repulled even if the CatalogSource is recreated
# So we'll pull latest, get the sha, and use that instead

export BUNDLEDIGEST=$(oc image mirror --dry-run=true quay.io/jmontleon/kiosk-operator-index:latest=quay.io/jmontleon/kiosk-operator-index:dry 2>&1 | grep -A1 manifests | grep sha256 | awk -F' ' '{ print $1 }')

sed "s/:latest/@$BUNDLEDIGEST/" catalogsource.yaml | oc create -f -
