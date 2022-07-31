# Terraform sample files

my-infra folder contains a sample Terraform stack used in the videos

my-remote-state folder contains a sample Terraform stack for creating a remote state for Terraform

You can use the my-infra samples with local statefile as well, but then you'd need to comment out the 'backend.tf' file that uses remote state resources (that you need to have created).
