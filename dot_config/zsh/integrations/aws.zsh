# Fix for https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/aws/aws.plugin.zsh

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

# Override original aws plugin's asp function to set the correct region
functions[original_asp]=$functions[asp]
functions[asp]=$functions[asp_with_regions]
