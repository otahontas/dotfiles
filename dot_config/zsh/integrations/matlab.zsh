# Add matlab to path
matlab_path=/Applications/MATLAB_R2023a.app/bin
[[ $PATH != *"$matlab_path"* ]] && export PATH="$matlab_path:$PATH"
