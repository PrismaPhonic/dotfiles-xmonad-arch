# Install aws cli
sudo pacman -S --noconfirm --needed aws-cli
aws configure

# Install gcloud sdk (includes cli)
paru -S google-cloud-sdk
gcloud init

# Install mercurial - need this now with go mod, can't remember why
sudo pacman -S --noconfirm --needed mercurial

# Set the release version variable
cd /tmp
RELEASE_VERSION=v1.6.1
curl -OJL https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu

# Verify the download release binary
curl -OJL https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu.asc

gpg --recv-key "0CF50BEE7E4DF6445E08C0EA9AFDE59E90D2B445"
gpg --verify operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu.asc

sudo chmod +x operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu \
&& sudo cp operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu /usr/local/bin/operator-sdk-v0.10.0

# Install gen-crd-api-reference-docs dep
GO111MODULE=on go get github.com/ahmetb/gen-crd-api-reference-docs

# Download the godoc server
go get golang.org/x/tools/cmd/godoc
