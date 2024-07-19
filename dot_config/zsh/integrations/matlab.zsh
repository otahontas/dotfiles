# Add matlab to path
matlab_path=/Applications/MATLAB_R2023b.app/bin

# Check if matlab path actually exists, report if not (happens when upgrading)
if [ ! -d "$matlab_path" ]; then
    echo "Matlab does not exist at: $matlab_path. Please update the correct path in matlab.zsh."
    return
fi

# Add matlab to path
[[ $PATH != *"$matlab_path"* ]] && export PATH="$matlab_path:$PATH"
