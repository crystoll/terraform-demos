
variable "environments" {
  type = list(string)
  default = [
    "dev",
    "test",
    "prod",
  ]
}



module "my_fun_module" {
    source = "./modules/superbucket"
    count = length(var.environments)
    bucket_name = "my-stupid-bucket-675675675-${count.index}"
}