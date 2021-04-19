# SETUP SSH KEY - AFTER THIS IT WILL BE IN CLIPBOARD

# Install xclip so we can easily copy ssh key to clipboard
sudo pacman -S --needed --noconfirm xclip

# Create ssh key for use w/ github
ssh-keygen -t rsa -b 4096 -C "Peter@PrismaPhonic.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# Copy SSH Key to clipboard
xclip -sel clip < ~/.ssh/id_rsa.pub
