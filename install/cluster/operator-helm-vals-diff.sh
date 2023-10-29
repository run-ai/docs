#!/bin/bash
set -e

function main() {
    parse_args "$@"

    verify_util_is_installed dyff "please install dyff: https://github.com/homeport/dyff and add it to your path"
    verify_util_is_installed helm "please install helm: https://helm.sh/ and add it to your path"

    # if current_values_file is empty - save current values to a temp file
    tmp_current_values_file=current-vals-$RANDOM.yaml
    if [[ -z $current_values_file ]]; then
        grab_current_values_file  $tmp_current_values_file
    else
        cp "$current_values_file" $tmp_current_values_file
    fi

    #remove first comment line
    cross_platform_sed '/USER-SUPPLIED VALUES:/d' $default_values_file
    cross_platform_sed '/USER-SUPPLIED VALUES:/d' $tmp_current_values_file

    # Perform diff between the two files
    dyff between $tmp_current_values_file $default_values_file  --color=on | tail --lines=+7

    rm $tmp_current_values_file
}

function help {
    echo ""
    echo "During upgrade - we override existing configurations on the cluster, with the ones we define as default."
    echo "$(basename $0) is aimed to assist discovering which values were manually modified on the cluster."
    echo "How to use it:"
    echo "    1. Use cluster installation instructions page, to grab the default cluster value"
    echo "       Note: you should select same cluster version, platform etc., which you used before"
    echo "    2. Grab the upgrade values file by executing the 'helm get values...' command from the cluster installation instructions page"
    echo "    3. Use this script in order to figure out which values were manually modified modified"
    echo "    4. If any found that you would like to preserve - modify the installation default values file accordingly and install"
    echo ""
    echo "Usage: $(basename $0) <default-values file> [-c current values file] [options]"
    echo "Options:"
    echo "  -c|--current-values <file name>     provide current values file"
    echo "  -v|--verbose                        switch verbosity on"
    echo "  -h|--help                           help"
}

function parse_args {
    current_values_file=

    while test $# -gt 0; do
        case "$1" in
          -c|--current-values)
              shift
              current_values_file="$1"
              if [[ ! -f "$current_values_file" ]]; then
                  echo_err "File '$current_values_file' was not found"
                  help
                  exit 1
              fi
                ;;
          -v|--verbose)
              set -x
              ;;
          -h|--help)
              help;
              exit 0
              ;;
          *)
              if [[ -n $default_values_file ]]; then
                  echo_err "'default-values file' parameter was already provided"
                  help
                  exit 1

              fi
              default_values_file="$1"
              ;;
        esac
        shift
    done

    if [[ -z $default_values_file ]]; then
        echo_err "Missing the default-values file parameter"
        exit 1
    fi

    if [[ ! -f $default_values_file ]]; then
        echo_err "File '$default_values_file' was not found"
        exit 1
    fi
}

verify_util_is_installed() {
    local cmd="$1"
    local msg="$2"

    if ! command -v $cmd &> /dev/null; then
        echo_err "$cmd could not be found, $msg"
        exit 1
    fi
}

echo_err() {
  echo "ERROR: $*"  >&2
}

cross_platform_sed(){
    if [ "$(uname)" == "Darwin" ]; then
       sed -i '' "$@"
    else
       sed -i    "$@"
    fi
}

grab_current_values_file(){
    helm get values runai-operator -n runai > "$1"
    # verify file was grabbed successfully
    if ! grep -c -q 'USER-SUPPLIED VALUES:' $tmp_current_values_file ; then
        echo "failed grabbing values from the cluster"
        exit 1
    fi

}

main "$@"