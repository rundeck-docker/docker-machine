# Shell functions for the docker-machine module.
#/ usage: source RERUN_MODULE_DIR/lib/functions.sh command
#

# Read rerun's public functions
. $RERUN || {
    echo >&2 "ERROR: Failed sourcing rerun function library: \"$RERUN\""
    return 1
}

# Check usage. Argument should be command name.
[[ $# = 1 ]] || rerun_option_usage

# Source the option parser script.
#
if [[ -r $RERUN_MODULE_DIR/commands/$1/options.sh ]] 
then
    . $RERUN_MODULE_DIR/commands/$1/options.sh || {
        rerun_die "Failed loading options parser."
    }
fi

# - - -
# Your functions declared here.
# - - -



parse_create_common_options() {
	local opts=()

	IFS=","
	[[ -n "${ENGINE_STORAGE_DRIVER:-}" ]] && opts=(${opts[*]:-} --engine-storage-driver $ENGINE_STORAGE_DRIVER)
	set -- $ENGINE_LABEL
	for englabel in $@
	do
	    opts=(${opts[*]:-} --engine-label $englabel)
	done
	set -- $ENGINE_OPT

	for engopt in $@
	do
	    opts=(${opts[*]:-} --engine-opt $engopt)
	done
	set -- $ENGINE_INSECURE_REGISTRY

	for enginsreg in $@
	do
	    opts=(${opts[*]:-} --engine-insecure-registry $enginsreg)
	done
	set -- $ENGINE_REGISTRY_MIRROR

	for engregmir in $@
	do
	    opts=(${opts[*]:-} --engine-registry-mirror $engregmir)
	done

	[[ "${SWARM:-}"        == "true" ]] && opts=(${opts[*]:-} --swarm)
	[[ "${SWARM_MASTER:-}" == "true" ]] && opts=(${opts[*]:-} --swarm-master)
	[[ -n "${SWARM_DISCOVERY:-}"     ]] && opts=(${opts[*]:-} --swarm-discovery $SWARM_DISCOVERY)
	[[ -n "${SWARM_HOST:-}"          ]] && opts=(${opts[*]:-} --swarm-host $SWARM_HOST)
	[[ -n "${SWARM_ADDR:-}"          ]] && opts=(${opts[*]:-} --swarm-addr $SWARM_ADDR)

	IFS=
	echo ${opts[*]:-}
}