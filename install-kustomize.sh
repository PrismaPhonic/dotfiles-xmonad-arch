opsys=linux  
curl -s "https://raw.githubusercontent.com/\
kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
chmod u+x kustomize
sudo mv kustomize $GOPATH/bin/kustomize
