#!/bin/bash
shopt -s nullglob

ENVIRONMENTS=( config/deploy/hosts/* )
ENVIRONMENTS=( "${ENVIRONMENTS[@]##*/}" )
NUM_ARGS=1

show_usage() {
  echo "
    Usage:
      ./rokket.sh deploy <environment>
      ./rokket.sh db <environment> <action>
      ./rokket.sh uploads <environment> <action>

      <environment> is the environment to deploy to ("staging", "production", etc)
      <action> is the database action ("push", "pull")

    Available environments:
      `( IFS=$' '; echo "${ENVIRONMENTS[*]}" )`

    Examples:
      ./rokket.sh deploy staging
      ./rokket.sh uploads staing push
      ./rokket.sh uploads production pull
      ./rokket.sh db staging push
      ./rokket.sh db production pull
    "
}

[[ $# -ne $NUM_ARGS ]] && { show_usage; exit 0; }

if [[ $1 = deploy ]]; then

  DEPLOY_CMD="ansible-playbook -i config/deploy/hosts/$2 config/deploy/deploy.yml"
  ENVIRONMENTS=( config/deploy/hosts/* )
  ENVIRONMENTS=( "${ENVIRONMENTS[@]##*/}" )
  NUM_ARGS=2

  show_usage() {
    echo "
      Usage:
        ./rokket.sh deploy <environment>

        <environment> is the environment to deploy to ("staging", "production", etc)

      Available environments:
        `( IFS=$' '; echo "${ENVIRONMENTS[*]}" )`

      Examples:
        ./rokket.sh deploy staging
        ./rokket.sh deploy production
      "
  }

  HOSTS_FILE="config/deploy/hosts/$2"

  [[ $# -ne $NUM_ARGS || $2 = -h ]] && { show_usage; exit 0; }

  if [[ ! -e $HOSTS_FILE ]]; then
    echo "Error: $2 is not a valid environment ($HOSTS_FILE does not exist)."
    echo
    echo "Available environments:"
    ( IFS=$'\n'; echo "${ENVIRONMENTS[*]}" )
    exit 0
  fi

  $DEPLOY_CMD

fi

if [[ $1 = db ]]; then

  DEPLOY_CMD="ansible-playbook -i config/deploy/hosts/$2 config/deploy/db_$3.yml"
  ENVIRONMENTS=( config/deploy/hosts/* )
  ENVIRONMENTS=( "${ENVIRONMENTS[@]##*/}" )
  NUM_ARGS=3

  show_usage() {
    echo "
      Usage:
        ./rokket.sh db <environment> <action>
      
        <environment> is the environment to deploy to ("staging", "production", etc)
        <action> is the database action ("push", "pull")

      Available environments:
        `( IFS=$' '; echo "${ENVIRONMENTS[*]}" )`

      Examples:
        ./rokket.sh db staging push
        ./rokket.sh db production pull
      "
  }

  HOSTS_FILE="config/deploy/hosts/$2"

  [[ $# -ne $NUM_ARGS || $2 = -h ]] && { show_usage; exit 0; }

  if [[ ! -e $HOSTS_FILE ]]; then
    echo "Error: $2 is not a valid environment ($HOSTS_FILE does not exist)."
    echo
    echo "Available environments:"
    ( IFS=$'\n'; echo "${ENVIRONMENTS[*]}" )
    exit 0
  fi

  $DEPLOY_CMD

fi

if [[ $1 = uploads ]]; then

  DEPLOY_CMD="ansible-playbook -i config/deploy/hosts/$2 config/deploy/uploads_$3.yml"
  ENVIRONMENTS=( config/deploy/hosts/* )
  ENVIRONMENTS=( "${ENVIRONMENTS[@]##*/}" )
  NUM_ARGS=3

  show_usage() {
    echo "
      Usage:
        ./rokket.sh uploads <environment> <action>

        <environment> is the environment to deploy to ("staging", "production", etc)
        <action> is the database action ("push", "pull")

      Available environments:
        `( IFS=$' '; echo "${ENVIRONMENTS[*]}" )`

      Examples:
        ./rokket.sh uploads staging push
        ./rokket.sh uploads production pull
  "
  }

  HOSTS_FILE="config/deploy/hosts/$2"

  [[ $# -ne $NUM_ARGS || $2 = -h ]] && { show_usage; exit 0; }

  if [[ ! -e $HOSTS_FILE ]]; then
    echo "Error: $2 is not a valid environment ($HOSTS_FILE does not exist)."
    echo
    echo "Available environments:"
    ( IFS=$'\n'; echo "${ENVIRONMENTS[*]}" )
    exit 0
  fi

  $DEPLOY_CMD

fi