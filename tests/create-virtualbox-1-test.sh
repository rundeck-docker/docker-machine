#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m docker-machine -p create-virtualbox [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "create-virtualbox"

# ------------------------------
# Replace this test. 
it_fails_without_a_real_test() {
    exit 1
}
# ------------------------------

