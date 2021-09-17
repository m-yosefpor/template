#!/bin/bash
set -e
PROJECT_NAME=$(basename "`pwd`")
sed -i '' "s/TEMPLATE_SUBSTITUTE_PROJECT_NAME/$PROJECT_NAME/g" Makefile
sed -i '' "s/TEMPLATE_SUBSTITUTE_PROJECT_NAME/$PROJECT_NAME/g" README.md
sed -i '' "s/TEMPLATE_SUBSTITUTE_PROJECT_NAME/$PROJECT_NAME/g" .gitlab-ci.yml

PROJECT_GIT=$(git remote -v | grep origin | head -1 | awk '{ print $2 }')
