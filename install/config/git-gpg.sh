#!/bin/bash

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
