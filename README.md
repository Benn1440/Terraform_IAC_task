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

## Terraform plan

This displays, snippets of the resources to be created.

<img width="1032" alt="Screenshot 2024-07-24 at 09 16 16" src="https://github.com/user-attachments/assets/37020d1a-c0fe-4818-8751-6bd38ed03ac2">
<img width="1005" alt="Screenshot 2024-07-24 at 09 18 04" src="https://github.com/user-attachments/assets/5e76b684-9f2a-4c42-85aa-218cab699412">

<img width="1026" alt="Screenshot 2024-07-24 at 09 18 57" src="https://github.com/user-attachments/assets/a9b97f49-5a17-43f5-86d2-81a78c3e5785">
<img width="1326" alt="image" src="https://github.com/user-attachments/assets/a78f530a-9139-4932-a961-9583fa07cefa">
<img width="1328" alt="image" src="https://github.com/user-attachments/assets/9e3d5643-5ddf-49ac-80a0-4844a78d5156">
<img width="1330" alt="image" src="https://github.com/user-attachments/assets/485ef64e-8f01-4610-b64d-41822ff3ad26">
<img width="1303" alt="image" src="https://github.com/user-attachments/assets/95a4c05c-85ce-46b5-b48b-21f64040db4d">
<img width="1314" alt="image" src="https://github.com/user-attachments/assets/ec490c52-2997-42b0-8d17-e58611381641">

## Output of terraform plan 
* terraform plan -out=tfplan -json > tfplan.json
<img width="1439" alt="image" src="https://github.com/user-attachments/assets/a16b5bf6-68a4-4744-bbd7-b0d80c449c29">

## Terraform apply -auto-approve
Create the resources and state files.

<img width="728" alt="image" src="https://github.com/user-attachments/assets/1b8b547a-67b0-49bd-aedd-52148981e510">








