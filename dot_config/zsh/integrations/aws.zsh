# Wrapper for asp that sets correct region
function asp_with_regions() {
    # Run original function with params
    original_asp "$@"

    # Check if original failed, if so, return
    if [ $? -ne 0 ]; then
        return $?
    fi

    # Clear or set region depenging on the profile
    if [ $# -eq 0 ]; then
        unset AWS_REGION
    else
        profile="$1"
        export AWS_REGION="$(aws configure get region --profile $profile)"
    fi
}


# Wrapper for acp that sets correct region
function acp_with_regions() {
    # Run original function with params
    original_acp "$@"

    # Check if original failed, if so, return
    if [ $? -ne 0 ]; then
        return $?
    fi

    # Clear or set region depenging on the profile
    if [ $# -eq 0 ]; then
        unset AWS_REGION
    else
        profile="$1"
        export AWS_REGION="$(aws configure get region --profile $profile)"
    fi
}

# Override original aws plugin's asp and acp functions to set the correct region
functions[original_asp]=$functions[asp]
functions[asp]=$functions[asp_with_regions]
functions[original_acp]=$functions[acp]
functions[acp]=$functions[acp_with_regions]

# Setup proper config for aws
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
