##### Aliases

# Git Aliases
alias lg1="log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias lg2="log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias rebash='source ~/.bash_profile'
alias s='pmset sleepnow'
alias unscope="launchctl remove com.netskope.client.stagentui"

# FS Aliases
alias ll='ls -FGlAhp'
alias ...='cd ../../'
alias f='open -a Finder ./'
alias path='echo -e ${PATH//:/\\n}'
alias qfind="find . -name "

# Network Aliases
alias myip='curl icanhazip.com'
alias myptr='curl icanhazptr.com'
alias socks='lsof -i'
alias flushdns='dscacheutil -flushcache'
alias listeners='sudo lsof -i | grep LISTEN'

# Shortcut Aliases
alias tf='terraform'
