## Step 1: Create S3 Bucket

1. Navigate to the “AWS Management Console” page, type “S3” in the “Find Services” box and then select “S3”.
![Navigate to the S3 service](/img/1.png)

2. The Amazon S3 dashboard displays. Click “Create bucket”.
![Create a bucket](/img/2.png)

3. In the General configuration, enter a “Bucket name” and a region of your choice. Note: Bucket names must be globally unique.
![Bucket name](/img/3.png)

**One of the convenient naming conventions is my-123456789-bucket, where you can replace 123456789 with your 12 digit AWS account ID.**

4. In the Bucket settings for Block Public Access section, uncheck the “Block all public access”. It will enable the public access to the bucket objects via the S3 object URL.

**Note - We are allowing the public access to the bucket contents because we are going to host a static website in this bucket. *Hosting requires the content should be publicly readable.***

![Allow the public access to the bucket contents](/img/4.png)

5. Click “Next” and click “Create bucket”.

6. Once the bucket is created, click on the name of the bucket to open the bucket to the contents.

![Bucket my-014421265158-bucket configuration and content](/img/5.png)


## Step 2: Upload files to the S3 Bucket

1. Once the bucket is open to its contents, click the “Upload” button.

![Click on the Upload button](/img/6.png)

2. Click the "Add files" and “Add folder” button, and upload the starter code folder content from your local computer to the S3 bucket. 

    - Click "Add files" to upload the index.html file, and click "Add folder" to upload the css, img, and vendor folders.

    ![Click on the Add file and add folder](/img/7.png)

    - Do not select the starter-code folder. Instead, upload its content one-by-one.

    ![Upload one-by-one](/img/8.png)

    - Successfully uploaded starter code in the bucket
    ![Upload successful](/img/9.png)

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