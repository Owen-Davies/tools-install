## Verify go is installed
go version

# Install lf - file manager
env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest

#################################################################
# Install lazydocker
# A simple terminal UI for both docker and docker-compose, written in Go with the gocui library.
#################################################################
go install github.com/jesseduffield/lazydocker@latest

########################################################
# K9s - Kubernetes CLI To Manage Your Clusters In Style!
########################################################
go install github.com/derailed/k9s@latest

########################################################
# Vimwiki-GoDown - Vimwiki-GoDown is a Markdown to HTML converter for .md files that were created with Vimwiki.
# https://github.com/maqiv/vimwiki-godown 
########################################################
go get "github.com/maqiv/vimwiki-godown"

########################################################
# Install cointop - https://github.com/cointop-sh/cointop
#-------------------------------------------------------
# a fast and lightweight interactive terminal based UI
# application for tracking and monitoring 
# cryptocurrency coin stats in real-time.
########################################################
go get github.com/cointop-sh/cointop

########################################
# Install smug 
# - a tmux session manager written in go
########################################

mkdir -p ~/source/smug
git clone https://github.com/ivaaaan/smug.git ~/source/smug
cd ~/source/smug
go install
sudo cp ~/source/smug/completion/smug.bash /etc/bash_completion.d/

#################################################################
# lazygit
# A simple terminal UI for git commands
# https://github.com/jesseduffield/lazygit
#################################################################
go install github.com/jesseduffield/lazygit@latest

#################################################################
# slack-term
# a slack client for your terminal
# https://github.com/erroneousboat/slack-term
#################################################################
go get -u github.com/erroneousboat/slack-term
cd $GOPATH/src/github.com/erroneousboat/slack-term
go install .

#################################################################
# goreader 
# epub terminal reader
# https://github.com/taylorskalyo/goreader
#################################################################
go install github.com/taylorskalyo/goreader@latest

#################################################################
# tdash
# A terminal dashboard with stats from Google Analytics, GitHub, Travis CI, and Jenkins.
#################################################################
go get github.com/jessfraz/tdash

go install github.com/cheat/cheat/cmd/cheat@latest
