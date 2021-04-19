##################
## GOLANG SETUP ##
##################
GOVERSION=1.16.3

cd /tmp
wget https://dl.google.com/go/go${GOVERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${GOVERSION}.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

# Setup workspace for golang stuff
mkdir -p ~/go/src
mkdir -p ~/go/bin

export GOPATH=~/go
export PATH=$PATH:/$GOPATH/bin
