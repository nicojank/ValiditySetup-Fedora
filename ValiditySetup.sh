echo "Make sure you've enrolled the fingerprint sensor in Windows first!"
read -p "Press enter to continue"
echo "Installing build dependecies"
sudo dnf install -y libusb*-devel libtool nss nss-devel gtk3-devel glib2-devel openssl openssl-devel libXv-devel gcc-c++ gusb cmake gobject-introspection-devel gtkdoc-scan  
echo "Cloning 3v1n0's github repo for libfprint"
git clone https://github.com/3v1n0/libfprint
echo "Building libfprint fork"
meson libfprint libfprint/_build && sudo ninja -C libfprint/_build install
echo "Downloading older, but compatible fprintd version 1.90.9-2.rpm and the PAM module for  that fprintd"
curl https://kojipkgs.fedoraproject.org//vol/fedora_koji_archive06/packages/fprintd/1.90.9/2.fc34/x86_64/fprintd-1.90.9-2.fc34.x86_64.rpm 
curl https://kojipkgs.fedoraproject.org//vol/fedora_koji_archive06/packages/fprintd/1.90.9/2.fc34/x86_64/fprintd-pam-1.90.9-2.fc34.x86_64.rpm
echo "Installing the older fprintd version"
 sudo rpm -i --nodeps fprintd-pam-1.90.9-2.fc34.x86_64.rpm fprintd-1.90.9-2.fc34.x86_64.rpm
echo "Setup PAM modules"
sudo authselect enable-feature with-fingerprint
sudo authselect apply-changes

echo "Thanks for using my script!"
echo "Credits:"
echo "https://github.com/3v1n0 for the libfprint fork"
echo "Fedora archive for the old fprintd versions: https://koji.fedoraproject.org/koji/packageinfo?buildStart=50&packageID=7228&buildOrder=-completion_time&tagOrder=name&tagStart=0#buildlist"
echo "fprintd:https://fprint.freedesktop.org/"

