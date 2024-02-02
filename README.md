# ansible-terraform-vm

A skeleton to allow easy experimentation with VMs using Ansible and Terraform.


## Usage

    terraform init # required first time only
    ./setup-env.sh # idempotent
    . venv/bin/activate
    export OS_CLOUD=openstack
    terraform apply
    ansible-playbook site.yml
