## Introduction

### Project Overview
The cloud is perfect for hosting static websites that only include HTML, CSS, and JavaScript files that require no server-side processing. The whole project has two major intentions to implement:

- Hosting a static website on S3 and
- Accessing the cached website pages using CloudFront content delivery network (CDN) service. Recall that CloudFront offers low latency and high transfer speeds during website rendering.

**Note that Static website hosting essentially requires a public bucket, whereas the CloudFront can work with public and private buckets.**

In this project, you will deploy a static website to AWS by performing the following steps:

1. You will create a public S3 bucket and upload the website files to your bucket.
2. You will configure the bucket for website hosting and secure it using IAM policies.
3. You will speed up content delivery using AWS’s content distribution network service, CloudFront.
4. You will access your website in a browser using the unique CloudFront endpoint.

### Prerequisites:

- AWS Account
- Starter code

### Topics Covered:

- S3 bucket creation
- S3 bucket configuration
- Website distribution via CloudFront
- Access website via web browser

### Dependencies
###### Cloud Services

- Amazon Web Services S3 - Resource hosting and deployments
- AWS CloudFront - CDN for SPA
- AWS EKS - Backend API
- AWS DynamoDB - Persistent Datastore
- AWS Cognito - User Authentication

###### Performance Tracking and DevOps Tools:

- AWS CloudWatch - Performance and Health checks
- Sentry - Bug Reporting
    - Alternates:
    - TBD
- Google Analytics - Usage Reporting
    - Alternates:
    - Mixpanel
- Travis (CI/CD)

###### Frameworks:

- Ionic (Javascript) (Frontend)
- Node.js (Javascript) (Backend)