#!/bin/bash

# Nome da branch de origem do cherry-pick (onde está o último commit)
SOURCE_BRANCH="SaoGonAmarante"

# Pega o hash do último commit da branch de origem
LAST_COMMIT=$(git log -n 1 --pretty=format:"%H" $SOURCE_BRANCH)

# Lista todas as branches exceto a branch de origem
BRANCHES=$(git branch | grep -v $SOURCE_BRANCH)

# Faz checkout em cada branch e aplica o cherry-pick do último commit
for BRANCH in $BRANCHES
do
  echo "Fazendo checkout na branch $BRANCH"
  git checkout $BRANCH

  echo "Aplicando cherry-pick do commit $LAST_COMMIT para a branch $BRANCH"
  git cherry-pick $LAST_COMMIT

  if [ $? -ne 0 ]; then
    echo "Erro ao fazer cherry-pick na branch $BRANCH. Fazendo abort..."
    git cherry-pick --abort
  else
    echo "Cherry-pick feito com sucesso em $BRANCH!"
  fi
done

# Retorna para a branch original
git checkout $SOURCE_BRANCH

echo "Script concluído!"
