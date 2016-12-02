#!/usr/bin/env bash
#
# Copyright (C) 2016 The Libre-USAL project developers.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -o errexit
set -o nounset
set -o pipefail

cd "$(dirname "$0")"

INSTALLATION_DIR="/etc/libre-usal/infra"

if [ -z "${DEPLOYER}" ]; then
  echo "You need to set the DEPLOYER environment variable to deploy";
  echo "Run this script like:";
  echo "DEPLOYER=foo@server ./deploy.sh";
fi

cat <<EOF | ssh "${DEPLOYER}"
cd ${INSTALLATION_DIR} &&
git fetch origin &&
git reset --hard origin/master &&
./update.sh
EOF
