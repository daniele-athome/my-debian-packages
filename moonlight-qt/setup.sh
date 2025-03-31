#!/bin/bash

set -euo pipefail

DEB_VERSION="+custom"

if [[ ! "$COMMIT" =~ ^v[0-9.]*$ ]]; then
  # not a tagged version, use nightly version notation (see https://wiki.debian.org/Versioning#Nightly_Versioning)
  DEB_VERSION="~git$(date +%Y%m%d).${COMMIT:0:7}${DEB_VERSION}"
fi

cd /opt
dch --local "$DEB_VERSION" -p "Non-maintainer configuration release"
