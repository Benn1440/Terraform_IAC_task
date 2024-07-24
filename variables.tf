# variable "server_ami_id" {
#   type = string 
# }
# variable "ami_id" {
#   type = string
# }

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
  default     = "devopskey"
}

# variable "key_name_path" {
#   description = "Path to the SSH public key file"
#   type        = string
#   default     = "~/.ssh/devopskey.pub"
# }