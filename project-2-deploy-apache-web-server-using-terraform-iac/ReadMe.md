# Project Title: Deploy Apache Web Server using Terraform IaC

### Goal

Goal of this project to write Terraform IaC to deploy Apache Webserver in AWS cloud.

### Pre-requisites

1. Create below resources using  Terraform IaC
    1. Create S3 Bucket to store the terraform statefiles
    2. Create DynamoDB
2. Deploy VPC Network using Terrafom IaC and keep the state file in S3 backend.
3. Create below resources using Terraform IaC and keep the state file in S3 backend
    1. S3 Bucket to store the webserver configuration and PUT  user-data.sh  script file which will configure webserver
    2. SNS topic for notifications
    3. IAM Role
4. Golden AMI

### Pre-deployment

1. Create Global AMI
    1. AWS CLI
    2. Cloudwatch agent
    3. Install AWS SSM agent
2. Create Golden AMI using Global AMI for Nginx application
    1. Install Nginx
    2. Push custom memory metrics to Cloudwatch.
3. Create Golden AMI using Global AMI for Apache Tomcat application
    1. Install Apache Tomcat
    2. Configure Tomcat as Systemd service
    3. Install JDK 11
    4. Push custom memory metrics to Cloudwatch.
4. Create Golden AMI using Global AMI for Apache Maven Build Tool
    1. Install Apache Maven
    2. Install Git
    3. Install JDK 11
    4. Update Maven Home to the system PATH environment variable

### Deployment

1. Write Terraform IaC to deploy below resources in the VPC that was created in the Pre-Requisites step and keep the state file in S3 backend with state locking support.
    1. Create  IAM Role granting PUT/GET  access to S3 Bucket and Session Manager access.
    2. Create Launch Configuration with userdata script to pull the use-data.sh file from S3 and attach IAM role and [user-data.sh will configure the webserver]
    3. Create Auto Scaling Group with Min:1 Max: 1 Des: 1  in private subnet
    4. Create Target Group with health checks to and attach with Auto Scaling Group
    5. Create Application Load balancer in public subnet and configure Listener Port to route the traffic to the Target Group
    6. Create alias record in Hosted Zone to route the traffic to the Load balancer from public network.
    7. Create Cloudwatch Alarms to send notification when ASG state changes.
    8. Create Scaling Policies to scale out/Scale In when average CPU utilization is > 80%
2. Deploy Terraform IaC to create the resources

### Validation
1. Login to AWS Console and verify all the resources are deployed
2. Access the web application from public internet browser using the domain name.

### Destroy
1. Destroy the resources once the testing is over to save the billing.