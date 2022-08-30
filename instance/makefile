clean:
	@rm -rf .terraform
creat: clean
  @terraform init backend-config=chanti/terraform.tfstate
  @terraform apply -auto-approve

destroy:
   @terraform init
   @terraform destroy -auto-approve
