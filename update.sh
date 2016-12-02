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
set -o verbose

cd "$(dirname "$0")"

install() {
  apt-get install -y "$@"
}

echo "libre-usal.org" >/etc/hostname
install slapd ldap-utils
stow -d config -t /etc/ldap ldap

if [ -z "$(which stow)" ]; then
  install stow
fi

if [ -z "$(which git)" ]; then
  install git
fi
git submodule update --init

if [ -z "$(which make)" ]; then
  install build-essential
fi

if [ -z "$(which a2enmod)" ]; then
  install apache2
fi
stow -d config -t /etc/apache2 apache2
mkdir -p /var/www/vhosts
stow sites -t /var/www/vhosts

if [ -z "$(which postconf)" ]; then
  install postfix
fi
stow -d config -t /etc/postfix postfix

if [ -z "$(which sievec)" ]; then
  install dovecot-core dovecot-ldap dovecot-imapd
fi
stow -d config -t /etc/dovecot dovecot

if [ -z "$(which opendkim-genkey)"]; then
  install opendkim
fi
stow -d config -t /etc/opendkim opendkim
