# Add brew sbin to path
[[ $PATH != *"/usr/local/sbin"* ]] && export PATH=/usr/local/sbin:$PATH

# Use brew wrapper to update Brewfile 
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

# Add homebrew file directly to chezmoi
export HOMEBREW_BREWFILE=$(chezmoi source-path)/mac/packages/Brewfile
