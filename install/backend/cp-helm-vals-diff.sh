

function help {
    echo "Usage: $0 [options]"
    echo "  --runai-adm         path to the relevant runai-adm file"
    echo "  --domain            domain of the cluster (e.g test.run.ai) (not needed for openshift)"
    echo "  --version           your current runai-adm version"
    exit 1
}

function getargs {
    while test $# -gt 0; do
            case "$1" in
                --help)
                    help;
                    exit 0;
                    ;;
                --runai-adm)
                    shift
                    runai_adm_path=$1
                    shift
                    ;;
                --domain)
                    shift
                    domain=$1
                    shift
                    ;;
                --version)
                    shift
                    version=$1
                    shift
                    ;;
                *)
                    echo "$1 is not a recognized flag! try --help for help."
                    exit 1;
                    ;;
            esac
    done
}



getargs "$@"

# Check if dyff installed
if ! command -v dyff &> /dev/null
then
    echo "dyff could not be found, please install dyff: https://github.com/homeport/dyff and add it to your path"
    exit 1
fi

# Check if helm installed
if ! command -v helm &> /dev/null
then
    echo "helm could not be found, please install helm: https://helm.sh/ and add it to your path"
    exit 1
fi

# Check if jq installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found, please install jq: https://github.com/jqlang/jq and add it to your path"
    exit 1
fi

# Use default runai-adm if not provided, else use provided runai-adm
if [ -z "$runai_adm_path" ]; 
then
    runai_adm=runai-adm
else
    runai_adm=$runai_adm_path
fi

# Check if runai-adm installed
if ! command -v $runai_adm &> /dev/null
then
    echo "runai-adm could not be found, please add runai-adm to your path or pass it as an argument via --runai-adm"
    exit 1
fi


# Extract version from helm chart
current_cp_version=$(helm list -n runai-backend --output json | jq -r  '.[] | select(.chart | contains("runai-backend"))' | jq -r .app_version)
if [ -z "$current_cp_version" ]; then
    echo "Could not find runai-backend helm release in namespace runai-backend"
    exit 1
fi

# Extract version from runai-adm
current_runai_adm_version=$("$runai_adm" version | head -n 1 | awk '{print $2}')
if [ -z "$current_runai_adm_version" ]; then
    if [ -z "$version" ]; then
        echo "Could not find runai-adm version, please provide the version with --version flag"
        exit 1
    else
        current_runai_adm_version=$version
    fi
fi

# If versions are not the same, exit
if ! [ "$current_cp_version" = "$current_runai_adm_version" ]; then
    echo "runai-adm version and backend helm chart version are not the same, [runai-adm: $current_runai_adm_version] [backend helm chart: $current_cp_version], please provide a valid runai-adm file via runai_adm_path arg"
    exit 1
fi

# Get current values, remove first line which is a comment, save into a file
current_vals_file=current-vals-$RANDOM.yaml
helm get values -n runai-backend runai-backend | tail -n +2 > $current_vals_file

is_ocp=$(dyff json $current_vals_file | jq -r .openshift)

# If domain not provided exit
if [ -z "$domain" ] && [ "$is_ocp" == false ]; 
then
    echo "you must provide your domain via --domain flag! use --help for more info"
    exit 1
fi

# Generate new values for the same version
generated_vals_file=runai-backend-values.yaml
if [ "$is_ocp" = true ]; then
    $runai_adm generate-values --openshift --first-admin PLACEHOLDER > /dev/null
else
    $runai_adm generate-values --first-admin PLACEHOLDER --external-ips PLACEHOLDER --domain $domain > /dev/null
fi


# Perform diff between the two files
dyff between $current_vals_file $generated_vals_file --exclude backend.openshiftIdp.firstAdmin --exclude backend.https.key --exclude backend.https.crt --exclude nginx-ingress.controller.service.externalIPs

# Delete old values file
rm $current_vals_file
# Delete generated vals file
rm $generated_vals_file







