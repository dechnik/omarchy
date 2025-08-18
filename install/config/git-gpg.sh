#!/bin/bash

yay -S --noconfirm --needed pcsclite

tee ~/.config/git/ignore >/dev/null <<EOF
.idea
.direnv
result
EOF

git config --global alias.add-nowhitespace '!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -'
git config --global alias.graph 'log --decorate --oneline --graph'
git config --global alias.pushall '!git remote | xargs -L1 git push --all'

git config --global commit.gpgSign true

git config --global diff.lisp.xfuncname '^(((;;;+ )|\(|([ \t]+\(((cl-|el-patch-)?def(un|var|macro|method|custom)|gb/))).*)$'

git config --global diff.org.xfuncname '^(\*+ +.*)$'

git config --global feature.manyFiles true

git config --global filter.lfs.clean 'git-lfs clean -- %f'
git config --global filter.lfs.process 'git-lfs filter-process'
git config --global filter.lfs.required true
git config --global filter.lfs.smudge 'git-lfs smudge -- %f'

git config --global gpg.format openpgp
git config --global gpg.program gpg2

git config --global gpg.openpgp.program gpg

mkdir -p ~/.gnupg

tee ~/.gnupg/gpg-agent.conf >/dev/null <<EOF
enable-ssh-support
grab
pinentry-program /usr/bin/pinentry-gnome3
EOF

tee ~/.gnupg/scdaemon.conf >/dev/null <<EOF
pcsc-driver /usr/lib/libpcsclite.so
card-timeout 5
disable-ccid
EOF

tee ~/.gnupg/sshcontrol >/dev/null <<EOF
EE6FCD5EF119342E3A679BBA23A2A6BD2AC7ACC6
05095B28F0B05E3C2EA1820655692ED47A6EA731
EOF

tee ~/.gnupg/gpg.conf >/dev/null <<EOF
cert-digest-algo SHA512
charset utf-8
default-preference-list SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed
fixed-list-mode
keyid-format 0xlong
list-options show-uid-validity
no-comments
no-emit-version
no-symkey-cache
personal-cipher-preferences AES256 AES192 AES
personal-compress-preferences ZLIB BZIP2 ZIP Uncompressed
personal-digest-preferences SHA512 SHA384 SHA256
require-cross-certification
s2k-cipher-algo AES256
s2k-digest-algo SHA512
trust-model tofu+pgp
use-agent
verify-options show-uid-validity
with-fingerprint
EOF

tee ~/.config/systemd/user/link-gnupg-sockets.service >/dev/null <<EOF
[Install]
WantedBy=default.target

[Service]
ExecStart=/usr/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets
ExecStop=/usr/bin/rm $HOME/.gnupg-sockets
RemainAfterExit=true
Type=oneshot

[Unit]
Description=link gnupg sockets from /run to /home
EOF

systemctl --user daemon-reload
systemctl --user enable --now link-gnupg-sockets.service

sudo systemctl enable --now pcscd
