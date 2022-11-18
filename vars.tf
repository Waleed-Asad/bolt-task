variable "region" { }

variable "environment" {
  description = "The name of environment"
  default = "prod"
}

variable "account_1_assume_role" {
  description = "The ARN of the role to assume."
  default = ""
}

variable "account_2_assume_role" {
  description = "The ARN of the role to assume."
  default = ""
}