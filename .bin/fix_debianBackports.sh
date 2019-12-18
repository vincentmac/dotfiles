# https://unix.stackexchange.com/questions/492013/importing-keys-from-keyring-debian-org-fail
# Fix gpg key error when updating packages with apt from debian backports in ChromeOS Crostini Ubuntu container

# Download `debian-archive-keyring` from https://packages.debian.org/stretch/all/debian-archive-keyring/download
wget http://ftp.us.debian.org/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2017.5+deb9u1_all.deb

sudo dpkg -i debian-archive-keyring_2017.5+deb9u1_all.deb
rm debian-archive-keyring_2017.5+deb9u1_all.deb
