#!/bin/sh
[ -z "$AWS_ACCESS_KEY_ID" ] && echo -e "Missing environment variable:  AWS_ACCESS_KEY_ID" && exit 1;
[ -z "$AWS_SECRET_ACCESS_KEY" ] && echo -e "Missing environment variable:  AWS_SECERT_ACCESS_KEY" && exit 1;
[ -z "$AWS_SSH_PRIV_KEY_PATH" ] && echo -e "Missing environment variable:  AWS_SSH_PRIV_KEY_PATH\nPlease set this to the path for your SSH private key" && exit 1;
[ ! -r "$AWS_SSH_PRIV_KEY_PATH" ] && echo -e "Unable to read file pointed to by, AWS_SSH_PRIV_KEY_PATH, $AWS_SSH_PRIV_KEY_PATH" && exit 1;

ANS_CODE="../ansible/"

source ./common_vars
ansible-playbook -u ${EC2_USER} --private-key ${AWS_SSH_PRIV_KEY_PATH} ${ANS_CODE}/display_ec2_instance_information.yml --extra-vars "${EXTRA_VARS}"
