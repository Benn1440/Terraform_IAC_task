# Terraform Infrastructure as Code with AWS

Terraform is an open-source infrastructure-as-code software tool created by HashiCorp. With Terraform we can automate Infrastructure to provision and manage resources in any cloud or data center.

https://www.terraform.io/

https://developer.hashicorp.com/terraform?product_intent=terraform

For this project, an AWS IAM User was created with Administrator access.

<img width="1404" alt="image" src="https://github.com/user-attachments/assets/92ec10dc-f4e9-429f-84ba-751e5f3378f3">

On Visual Studio code there was the need to install the AWS Toolkits and Terraform extension, and after that login with the already generated Access key ID & Secret access key.

Which generated various AWS resource Templates in our selected Region.

<img width="1403" alt="image" src="https://github.com/user-attachments/assets/71f5f35d-19df-40bb-b40d-c341cbc9a52f">

# AWS Providers

Terraform uses a provider to interface with the Application Programming Interface (API) of any infrastructure you are trying to build available to the cloud service provider. ## https://registry.terraform.io/providers/hashicorp/aws/latest/docs

## Link to Architectural Diagram

https://lucid.app/lucidchart/d1b12868-4942-44dd-a6eb-a2639c3e9bc7/edit?invitationId=inv_c8a5d7bb-0a33-48e1-aa84-17e6eb487a99&page=0_0#

![image](https://github.com/user-attachments/assets/ec259597-b260-4d06-94ff-6fc241249cc9)

## Terraform Init

Running the terraform init within the working directory, terraform checks the provider's file installs required hashicorp files and then creates Two(2) extra files .terraform.lock.hcl ensures that the selected version is frozen, Which helps to avoid issues in cases of upgrade and a .exe file.

<img width="582" alt="image" src="https://github.com/user-attachments/assets/bdff2452-6e86-4394-84de-39de22f501b8">

