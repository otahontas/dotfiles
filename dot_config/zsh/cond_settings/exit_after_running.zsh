# By sourcing this file, zsh will exit after running one command. Exiting
# doesn't depend on programs return status.
precmd() { 
    if [[ $cmd_no -gt 0 ]]; then 
        exit; 
    else 
        ((cmd_no++)); 
    fi 
}
