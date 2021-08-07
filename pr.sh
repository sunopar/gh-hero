#!/bin/bash
bold=$(tput bold)
normal=$(tput sgr0)
usage(){
  echo "
  ${bold}USAGE${normal}
  gh pr <command> [flags]

  ${bold}COMMANDS${normal}
    publish:  automatically enter /publish xxx-ui in your PR comments to depoly dev and QA environment

  ${bold}EXAMPLES${normal}
    $ gh pr publish
"
}
publish(){
  pr=$(gh pr view --json number)
  pr_number=$(echo $(gh pr view --json number) | grep '[0-9]\{3,\}' -o)
  echo PR number: $pr_number

  app=$(echo $(gh pr view --json title) | grep -e '[a-zA-Z-]*ui' -o)
  echo app: $app

  echo $(gh pr comment $pr_number --body "/publish $app")
}

if ! command -v gh 1>/dev/null 2>&1; then
  echo You don\'t have gh, gh will be installed automatically
  echo $(brew install gh)
fi
if [ $1 = 'publish' ]; then
  publish
else
  printf "Please specify commands\n\n"

  usage
  exit 1
fi

