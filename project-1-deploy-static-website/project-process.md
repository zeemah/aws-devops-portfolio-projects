## Step 1: Create S3 Bucket

1. Navigate to the “AWS Management Console” page, type “S3” in the “Find Services” box and then select “S3”.
![Navigate to the S3 service](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/1.png)

2. The Amazon S3 dashboard displays. Click “Create bucket”.
![Create a bucket](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/2.png)

3. In the General configuration, enter a “Bucket name” and a region of your choice. Note: Bucket names must be globally unique.
![Bucket name](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/3.png)

**One of the convenient naming conventions is my-123456789-bucket, where you can replace 123456789 with your 12 digit AWS account ID.**

4. In the Bucket settings for Block Public Access section, uncheck the “Block all public access”. It will enable the public access to the bucket objects via the S3 object URL.

**Note - We are allowing the public access to the bucket contents because we are going to host a static website in this bucket. *Hosting requires the content should be publicly readable.***

![Allow the public access to the bucket contents](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/4.png)

5. Click “Next” and click “Create bucket”.

6. Once the bucket is created, click on the name of the bucket to open the bucket to the contents.

![Bucket my-014421265158-bucket configuration and content](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/5.png)


## Step 2: Upload files to the S3 Bucket

1. Once the bucket is open to its contents, click the “Upload” button.

![Click on the Upload button](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/6.png)

2. Click the "Add files" and “Add folder” button, and upload the starter code folder content from your local computer to the S3 bucket. 

    - Click "Add files" to upload the index.html file, and click "Add folder" to upload the css, img, and vendor folders.

    ![Click on the Add file and add folder](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/7.png)

    - Do not select the starter-code folder. Instead, upload its content one-by-one.

    ![Upload one-by-one](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/8.png)

    - Successfully uploaded starter code in the bucket
    ![Upload successful](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/8.png)

### 2 ways to upload to S3

Sometimes the local machine's network setting or firewall might block, or the browser's Adblocker may prohibit the file upload, such as buysellads.svg file. In such a case, here are the workarounds:

    - Workaround 1

    Try using Chrome browser, and turn off the Adblocker, if not already. Here are the steps to turn off the Adblocker in Chrome:

    1. At the top right, click More (three dots) >> Settings.
    2. Click Security and Privacy >> Site Settings.
    3. Click Additional content settings >> Ads.
    4. Turn off Block ads on sites that show intrusive or misleading ads.

    - Workaround 2

    Use CLI commands to upload the files and folders:

    1. Verify the AWS CLI configuration. If not configured already, use:

    ```
    aws configure list
    aws configure 
    aws configure set aws_session_token "<TOKEN>" --profile default 
    ```

    2. Upload files

    ```
    # Create a PUBLIC bucket in the S3, and verify locally as 
    aws s3api list-buckets 
    # Download and unzip the udacity-starter-website.zip 
    cd udacity-starter-website 
    # Assuming the bucket name is my-bucket-202203081 and your PWD is the "udacity-starter-website" folder 
    # Put a single file. 
    aws s3api put-object --bucket my-bucket-202203081 --key index.html --body index.html 
    # Copy over folders from local to S3 
    aws s3 cp vendor/ s3://my-bucket-202203081/vendor/ --recursive 
    aws s3 cp css/ s3://my-bucket-202203081/css/ --recursive 
    aws s3 cp img/ s3://my-bucket-202203081/img/ --recursive
    ```

## Step 3: Secure Bucket via IAM

1. Click on the “Permissions” tab. 
    - Go to the Permissions tab. See that the bucket allows public access for hosting.

    ![permissions](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/10.png)

2. The “Bucket Policy” section shows it is empty. Click on the Edit button.

    ![bucket policy](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/11.png)
    - Empty bucket policy. Check this policy again after setting up the CloudFront distribution.

3. Enter the following bucket policy replacing your-website with the name of your bucket and click “Save”.

    ```
    {
    "Version":"2012-10-17",
    "Statement":[
        {
        "Sid":"AddPerm",
        "Effect":"Allow",
        "Principal": "*",
        "Action":["s3:GetObject"],
        "Resource":["arn:aws:s3:::your-website/*"]
        }
    ]
    }
    ```
    You will see warnings about making your bucket public, but **this step is required for static website hosting.**

    **Note** - If we were not learning about static website hosting, we could have made the bucket private and wouldn't have to specify any bucket access policy explicitly. In such a case, once we set up the **CloudFront distribution**, it will automatically update the current bucket access policy to access the bucket content. The CloudFront service will make this happen by using the **Origin Access Identity** user.

## Step 4: COnfigure S3 Bucket

1. Go to the **Properties** tab and then scroll down to edit the **Static website hosting** section.
![properties](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/12.png)

![edit](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/13.png)

2. Click on the “Edit” button to see the **Edit static website hosting** screen. Now, enable the **Static website hosting**, and provide the default home page and error page for your website.
![edit static hosting]([/img/14.png](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/14.png))

3. For both “Index document” and “Error document”, enter “index.html” and click “Save”. After successfully saving the settings, check the **Static website hosting** section again under the **Properties** tab. You must now be able to view the website endpoint(opens in a new tab) as shown below:
![edit](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/15.png)
- Copy the website endpoint for future use.

## Step 5: Distribute website via CloudFront

1. Select “Services” from the top left corner and enter “cloud front” in the “Find a service by name or feature” text box and select “CloudFront”.
![cloudfront services](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/16.png)

2. From the CloudFront dashboard, click “Create Distribution”.
![cloudfront dashboard](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/17.png)

3. For “Select a delivery method for your content”, click “Get Started"
![cloudfront delivery method](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/18.png)

4. Use the following details to create a distribution:
| Field | Value |
| ----------- | ----------- |
| Origin > Domain Name | Don't select the bucket from the dropdown list. Paste the Static website hosting endpoint of the form `.s3-website-region.amazonaws.com` |
| Origin > Enable Origin Shield | No |
| Default cache behavior | Use default settings |
| Cache key and origin requests | Use default settings |

![cloudfront delivery](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/19.png)
![cloudfront- configuations- origin details](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/20.png)

5. Leave the defaults for the rest of the options, and click “Create Distribution”. It may take up to 10 minutes for the CloudFront Distribution to get created.

**Note**: It may take up to **10 minutes** for the CloudFront Distribution to be created.

6. Once the status of your distribution changes from “In Progress” to “Deployed”, copy the endpoint URL for your CloudFront distribution found in the “Domain Name” column.

**Note** - Remember, as soon as your CloudFront distribution is **Deployed**, it attaches to S3 and starts caching the S3 pages. CloudFront may take 10-30 minutes (or more) to cache the S3 page. Once the caching is complete, the CloudFront domain name URL will stop redirecting to the S3 object URL.
![Configurations - Cache behavior, key and origin requests](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/21.png)

In this example, the Domain Name value is dgf7z6g067r6d.cloudfront.net, **but yours will be different**.

## Step 6: Access Website in Web Browser

**Note** - In the steps below, the exact domain name and the S3 URLs will be different in your case.

1. Open a web browser like Google Chrome, and paste the copied CloudFront domain name (such as, `dgf7z6g067r6d.cloudfront.net`) *without appending* `/index.html `at the end. The CloudFront domain name should show you the content of the default home-page, as shown below:

![cloudfront- configuations- origin details](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-1-deploy-static-website/img/22.png)
The figure above shows the page displayed at `https://dgf7z6g067r6d.cloudfront.net`

2. Access the website via website-endpoint, such as `http://<bucket-name>.s3-website.us-east-2.amazonaws.com/`.

3. Access the bucket object via its S3 object URL, such as,` https://<bucket-name>.s3.amazonaws.com/index.html`.

All three links: CloudFront domain name, S3 object URL, and website-endpoint will show you the same `index.html` content.

**If we were not "hosting" the website on S3, we could have made the bucket private and host the content only through the CloudFront domain name. In such a case, we cannot access the private content using S3 object URL and website-endpoint.**
