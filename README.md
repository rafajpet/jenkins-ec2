# Ansible Jenkins instalation on AWS ec2 instance

This project was created to learn basic concept behind AWS and instalation of jenkins into ec2 instance via ansible

## Configuration

For working with AWS. You have to create file [ansible/vars/sensitive.yml](ansible/vars/sensitive.yml) and add property

    aws_access_key: "you access key"

Your access key with admin access to AWS or restricted access with `VPC, subnets, security groups, ec2, ebs` permissions

    aws_secret_key: "your secret key"

Your secret key

    aws_region: "AWS region for instalation"


## Instalation

### 1. Install ansible

    source install_ansible.sh

Run script `install_ansible.sh` to install ansible into control machine


### 2. Update IP address for restriction regarding ssh access to ec2 instance

Check you ip address via https://whatismyipaddress.com/ and update
property `ec2_ssh_ip_allowed` in folder [ansible/vars/jenkins/config.yml](ansible/vars/jenkins/config.yml)

### 3. Run playbook

    ansible-playbook create_jenkins.yml

This script contains roles for setting AWS components. Create `VPC, security group, subnets, ec2, ebs`
and install `java and jenkins`


## Info

If you want to access ec2 instance via ssh, use command `ssh -i ~/.ssh/private-cloud-work ubuntu@<public-dns-of-created-ec2-instace>`
DNS name of ec2 instance is printed during creation in ansible output

## Remove all components

    ansible-playbook remove-jenkins.yml

Remove all components from AWS deployment.

## Configuration

For configuration please look at [ansible/vars/jenkins/config.yml](ansible/vars/jenkins/config.yml)
