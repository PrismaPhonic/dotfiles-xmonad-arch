# /etc/profile

#Set our umask
umask 022

# Set our default path
PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:$HOME/.config/bspwm:$HOME/.config/bspwm/panel:$HOME/.bin:/usr/lib/go/bin:$HOME/go/bin:$HOME/.cargo/bin"
export PATH
export XDG_CONFIG_HOME="$HOME/.config"
export BSPWM_SOCKET="/tmp/bspwm-socket"
export XDG_CONFIG_DIRS=/usr/etc/xdg:/etc/xdg
export _JAVA_AWT_WM_NONREPARENTING=1

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
	for profile in /etc/profile.d/*.sh; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi

# Source global bash config
if test "$PS1" && test "$BASH" && test -r /etc/bash.bashrc; then
	. /etc/bash.bashrc
fi

# Termcap is outdated, old, and crusty, kill it.
unset TERMCAP

# Man is much better than us at figuring this out
unset MANPATH
BROWSER=/usr/bin/firefox-developer-edition
export GOPATH=$HOME/go
export GOROOT=/usr/lib/go

