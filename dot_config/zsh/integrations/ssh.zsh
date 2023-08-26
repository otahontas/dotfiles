# Use 1password as ssh agent
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# Note: there's also launchagent for GUIs, load it once with:
# launchctl load -w ~/Library/LaunchAgents/com.1password.SSH_AUTH_SOCK.plist
# See more: https://developer.1password.com/docs/ssh/agent/compatibility

# Add SSH hostname completions from ~/.ssh/config
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi

if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi
