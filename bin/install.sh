    export BINARY_DIR=$(realpath $(dirname $0))

    # Build Project
    echo + INSTALL [$1]
    echo ------------------------------

    sources=".\"$1\""
    sources=$(jq ${sources} ${BINARY_DIR}/install.json)
    for exercise in ${sources//":"/" "}; do
        git checkout main -- ${exercise} ; \
    done



