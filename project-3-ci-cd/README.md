# Give your application Auto-deploy superpowers

## Project Objectives

In this project, you will prove your mastery of the following learning objectives (or sections):

1. Explain the fundamentals and benefits of CI/CD to achieve, build, and deploy automation for cloud-based software products.
2. Utilize Deployment Strategies to design and build CI/CD pipelines that support Continuous Delivery processes.
3. Utilize a configuration management tool to accomplish deployment to cloud-based servers.
4. Surface critical server errors for diagnosis using centralized structured logging.

## Selling CI/CD
### Section 1

### Explain the Fundamentals and Benefits of CI/CD to Achieve, Build, and Deploy Automation for Cloud-Based Software Products
You are leading a team to develop the UdaPeople product, a revolutionary concept in Human Resources which promises to help small businesses care better for their most valuable resource: their people. Before implementing CI/CD for the UdaPeople product, you need authorization from the people who write the checks. Create a proposal in document or presentation form that "sells" the concept of CI/CD to non-technical decision-makers in the UdaPeople organization.

While writing this proposal document/presentation, step out of your technical role and step into the world of revenue and costs. You will need to translate the benefits of CI/CD from technical language to the business's values. To appeal to what makes business people tick, you'll need to focus on benefits that create revenue, protect revenue, control costs, or reduce costs.

The deliverable should be "near-production-quality", but you should try to time-box your work to about 30 minutes. In other words, it should be good enough to submit to a manager in a real job. It should not be a messy or last-minute submission. You may use public domain or open source templates and graphics if you'd like. But please make sure the content is your own. Your presentation should be no longer than 5 slides. Your manager prefers to view presentations that are short and sweet!

Your presentation should be in PDF format named "presentation.pdf" and should be included in your code repository root folder.

## Step 1: Getting Started

Let's download and get familar with the start code.

### Prerequisites
Ensure to have these tools installed on your local machine:

- Git - Once installed, you can verify using:
```git --version```
- SH client like OpenSSH. Linux/Mac users can use the default terminal.
- **Optional** tools - if you plan on compiling locally:
    - NodeJs v13.8 and NPM v6.XX
    - If you already have another NodeJS installed, refer to this thread on Changing the NodeJS version using Node version manager (nvm).

### Starter Code
1. Fork and then clone the starter code to your machine so that you can manipulate the files.

2. As you develop the project, ensure that you push your code into a repository in your account in Github. You might consider making your repository public so that Circle CI will give you more credits to run builds (more information here).

3. Here is the directory structure relevant for the project:
```
.
├── .circleci # You will develop the files in this directory. 
│   ├── ansible
│   └── files
├── backend  # Do not run npm commands here (on your local machine). 
│   ├── src
│   └── test
├── frontend # Do not run npm commands here (on your local machine). 
│   ├── src
│   └── types
└── util     # Files relevant for the running the app locally (Optional).
```
### Contents of the `.circleci` directory
1. **CloudFormation templates** - For your convenience, we have provided necessary CloudFormation templates that you can use throughout the deployment phase of your project. You can find those templates in the **/.circleci/files** folder. It has these files:

- *cloudfront.yml* - We will instruct you to use this file to manually create a stack.
- *backend.yml* and *frontend.yml* - Your CircleCI job will run these files. We will hold you along the step-by-step instructions ahead.
- Note that no changes are required in three files mentioned above, except updating the EC2 key pair name and suitable AMI name in the backend.yml file later.
2. **Ansible Playbooks and Roles** - The `/.circleci/ansible` directory contains the playbook files and roles that you will develop, per instructions on the next page.

3. **CircleCI `config.yml` file** - We left a scaffolded/incomplete `/.circleci/config.yml` file to help you get started with CirlcCI's configuration. This file has intentionally failing/incomplete jobs. To call attention to unfinished jobs, we left some "non-zero error codes" (e.g. `exit 1`) for you to remove when you have finished implementing the jobs.

`The starter config.yml file will not work out-of-the-box. It is provided to help you understand the final structure of the CircleCI configuration.`

### The backend and the frontend
`**Tip**: It is a good practice to read through the frontend and backend README.`

Do not run NPM commands either in the backend or the frontend folders on your local machine. Instead, you will run the suitable NPM commands as part of the CircleCI jobs.

Also, note that we have provided an easy-to-fix compile error in the backend. In addition, there is one failing test in both the frontend and backend. Details are present in the next section. This means, **the starter code will not work out of the box on your local machine** either.

### Screenshots and URLs
Throughout this project, you will be asked to take screenshots or provide URLs to aid in the evaluation process once you're done with the project (see details in the Rubric below).

It's worth mentioning here since it's much harder to harvest some screen shots once you've passed certain milestones. **It's best if you take screenshots along the way and store them in a folder on your computer until you're ready to turn the project in**. Also, it's good to keep a document or notepad with the list of urls that are requested.

## Deploying Working, Trustworthy Software
### Section 2
### Utilize Deployment Strategies to Design and Build CI/CD Pipelines that Support Continuous Delivery Processes

#### Set up CircleCI
- Set up a CircleCI **free account**, if you haven't already, that you can use throughout this project. The free account includes 2500 credits per week which equals around 70 builds. This should be enough as long as you are conservative with your builds. If you run out of credits, you can create another account and continue working.

- Create a new project in CircleCI using your project (forked) GitHub repo.

- Ensure a workflow starts with the jobs in your `config.yml` file. If you need to take a look at some samples, Circle CI was nice enough to give us a few.

`If your Github repo is connected to CircleCI correctly, then the commits/pushes to repo will trigger the CI/CD pipeline automatically.`

## ToDo
Let's start coding different jobs in the `.circleci/config.yml` file.

`Tip: We suggest you make a copy of the existing config file, as config-sample.yml for reference, and start afresh from scratch.`

## 1. Build Phase
The goal of a build phase is to compile/lint the source code to check for syntax errors or unintentional typos in code. Note that throughout this project, you should have separate jobs for the frontend and backend so that failure alerts are more descriptive.

- Find the job named `build-frontend` in the `.circleci/config.yml` file.

    - Select a Docker image that is compatible with NodeJS.
    `- image: circleci/node:13.8.0`
    - Add code to build/compile the front-end.
    ``` cd frontend
        npm install
        npm run build
    ```
- Find another job named `build-backend`
    - Select a Docker image that is compatible with NodeJS.
    - Add code to build/compile the back-end.
- Add jobs to the `workflows` section, if not already.
- Push your commits. It will trigger the CircleCI pipeline. Jobs should fail if code cannot be compiled (fail for the right reasons), and **a failed build should stop all future jobs**. We have provided an easy-to-fix compile error in the code to prove the jobs fail. Provide a screenshot of jobs that failed because of compile errors. **[SCREENSHOT01]**
- Fix the intentional error in the `/backend/src/main.ts` file that caused the compilation error. See code-comment that guides you to the fix. On pushinig your changes to the repo, the pipeline will continue.

## 2.Test Phase
Unit tests are one of the many very important building blocks of a system that enables Continuous Delivery (notice, we didn’t say “the only or most important thing”). UdaPeople believes that tests should come first just like they do in the scientific method. So, if a test fails, it's because the code is no longer trustworthy. Only trustworthy code should get a ticket to continue the ride!

In this test phase, remember that we separate the frontend and backend into separate jobs!

- Find the `test-frontend` job in the config file.
    - Select the Docker image that is compatible with NodeJS.
    - Write code to run the unit tests.
        ``` cd frontend
        npm install
        npm run test```
- Find the `test-backend` job, and perform the similar steps.
- Add jobs to the `workflows` section, if not already.
- Push your commits. It will trigger the CircleCI pipeline. Both the above unit test jobs should fail due to the intentional failing tests (details in the next point) and prevent any future jobs from running.
- Provide a screenshot of the failed unit tests in the "Test Failures" tab. [SCREENSHOT02]
- We have provided the following intentional failing test in both frontend and backend. See code-comment that guides you to the fix:
    - frontend/src/app/components/LoadingMessage/LoadingMessage.spec.tsx
    - backend/src/modules/domain/employees/commands/handlers/employee-activator.handler.spec.ts
Fix the unit tests and make the job succeed.

## 3. Analyze Phase
UdaPeople handles some private information like social security numbers, salary amount, etc. It would be not be ideal if a package with a known vulnerability left a security hole in our application, giving hackers access to that information! That’s why we should include a job that checks for known vulnerabilities every time we check in new code.

- Find the `scan-frontend` job in the config file.
    - Select a Docker image that is compatible with NodeJS.
    - Use `npm` to “audit” the code to check for known security vulnerabilities in the packages.
    ```cd frontend
        npm install
        ## npm install oauth-sign@^0.9.0
        npm audit --audit-level=critical
    `Note that the --audit-level parameter above specifies the minimum vulnerability level that will cause the command to fail. This option does not filter the report output, it simply changes the command's failure threshold.` 
- Find the `scan-backend` job in the config file, and perform the similar steps.
- Add jobs to the `workflows` section, if not already. Also, a failed analysis should stop all future jobs.
- Push your commits. Job should fail due to critical vulnerabilities present in the starter code (fail for the right reasons). We left you an intentional vulnerability to cause a failure (details in the next point below). Provide a screenshot of jobs that failed because of vulnerable packages listed. **[SCREENSHOT03]**
- One of the ways to fix the critical vulnerabilities in your local is to run the fix command individually in both frontend and backend:
    ```## Do not use the --force option along with the command below in your local
    npm audit fix --audit-level=critical```
But, the command above may:

- leave behind few critical vulnerabilities that require manual review.
- behave differently on different Node/npm versions locally.
- cause the build/test job to fail.
In addition, the vulnerabilities evolve with time.
- Therefore, you need to upgrade the vulnerable packages in the *backend/package.json* file in your local manually to:
    ```"class-validator": "0.12.2"
    "standard-version": "^7.0.0"```
`The idea here is to have you understand how to fix the vulnerable packages in the code. However, the prime objective of the project is building CI/CD pipelines on AWS.`

- To make the `scan-frontend` and `scan-backend` jobs pass, you can use the following code in the jobs:
    ```npm audit fix --audit-level=critical --force
    ## If the "npm audit fix" command above could not fix all critical vulnerabilities, try “npm audit fix --force” again
    npm audit --audit-level=critical```
Note that the `npm audit fix` in the jobs above will not have any impact on the actual code being deployed in the further jobs.

- Push your commits to the remote repository on Github.

## 4. Alerts
When a build fails for any reason, the UdaPeople dev team needs to know about it. That way they can jump in and save the day. You’re going to add an alert so that botched builds raise a nice wavy red flag.

- Integrate Slack, email or another communication tool to receive alerts when jobs fail. Our examples are using Slack, but you should feel free to use the communication tool to which you are most accustomed.
- The steps for configurinig the Slack notification are
    - Setup Authentication(opens in a new tab)
    - Integrate Slack orb
- Recently, the CircleCI has auto-enabled the email notification for all failed builds.
- Provide a screenshot of an alert from one of your failed builds. **[SCREENSHOT04]**

## Configuration Management
### Section 3
#### Utilize a Configuration Management Tool to Accomplish Deployment to Cloud-Based Servers
In this section, you will practice creating and configuring infrastructure before deploying code to it. You will accomplish this by preparing your AWS and CircleCI accounts just a bit, then by building Ansible Playbooks for use in your CircleCI configuration.

### Setup - AWS
1. Create and download a **new key pair** in AWS. Name this key pair "udacity" so that it works with your Cloud Formation templates. Look for "Option 1: Create a key pair using Amazon EC2" in this tutorial(opens in a new tab), if you need help. You'll be using this key pair (pem file) in future steps so keep it in a memorable location.

2. Create IAM user for programmatic access only and copy the access key id and secret access key. Refer to the page titled **AWS Install and Configure CLI** in the lesson titled **Introduction to CI/CD** for instructions related to configuring AWS CLI with programmatic access. Configure your AWS CLI to use the newly generated access keys. You'll also need these credentials to add to CircleCI configuration in the next steps.

3. Add a PostgreSQL database in RDS that has public accessibility. This tutorial may help.(opens in a new tab) As long as you marked "Public Accessibility" as "yes", you won't need to worry about VPC settings or security groups. Take note of the connection details, such as:

    ```Endpoint (Hostname): database-1.ch4a9dhlinpw.us-east-1.rds.amazonaws.com 
    Instance identifier: database-1 //This is not the database name
    Database name: postgres (default)
    Username: postgres
    Password: mypassword
    Port: 5432```
Note that the AWS wizaard will create a default database with name postgres. If you wish to give another name to the initial database, you can do so in the additional configuration as shown in the snapshot below.

**Optional**: Verify the connection to the new database from your local SQL client, using this tutorial (https://aws.amazon.com/getting-started/hands-on/create-connect-postgresql-db/)

### Setup - CloudFront Distribution Primer
At the very end of the pipeline, you will need to make a switch from the old infrastructure to the new as you learned about with the Blue Green Deployment strategy. We will use CloudFormation and CloudFront to accomplish this. However, for this to work, you must do a few things manually:

1. Choose a random string, such as `kk1j287dhjppmz437`

2. Create a public S3 bucket with a name that combines "udapeople" and the random string, such as `udapeople-kk1j287dhjppmz437`. If S3 complains that the name is already taken, just choose another random string. The random string is to distinguish your bucket from other student buckets.

3. Manually run the provided `.circleci/files/cloudfront.yml` template file locally, and use bucket name for the Workflow ID parameter, as shown in the example command below. In the template file, the Workflow ID parameter represents the bucket name.

    ```cd .circleci/files
    aws cloudformation deploy \
        --template-file cloudfront.yml \
        --stack-name InitialStack\
        --parameter-overrides WorkflowID=udapeople-kk1j287dhjppmz437```
Upon successful execution, the *cloudfront.yml* template file will create a CloudFront Distribution connected to your existing S3 bucket, and a CloudFrontOriginAccessIdentity.

Once the initial stack is created, subsequent executions of the *cloudfront.yml* template will modify the same CloudFront distribution to make the blue-to-green switch without fail.

#### Setup - CircleCI
1. Add SSH Key pair from EC2 to the CircleCI Project Settings > SSH Keys > Additional SSH Keys, as shown here(opens in a new tab). To get the actual key pair, you'll need to open the pem file in a text editor and copy the contents. Then you can paste them into Circle CI.

2. Add the following environment variables to your Circle CI project by navigating to {project name} > Settings > Environment Variables as shown here(opens in a new tab):
    - `AWS_ACCESS_KEY_ID`=(from IAM user with programmatic access)
    - `AWS_SECRET_ACCESS_KEY`= (from IAM user with programmatic access)
    - `AWS_DEFAULT_REGION`=(your default region in aws)
    - `TYPEORM_CONNECTION`=`postgres`
    - `TYPEORM_MIGRATIONS_DIR`=`./src/migrations`
    - `TYPEORM_ENTITIES`=`./src/modules/domain/**/*.entity.ts`
    - `TYPEORM_MIGRATIONS`=`./src/migrations/*.ts`
    - `TYPEORM_HOST`={your postgres database hostname in RDS}
    - `TYPEORM_PORT`=`5432` (or the port from RDS if it’s different)
    - `TYPEORM_USERNAME`={your postgres database username in RDS}
    - `TYPEORM_PASSWORD`={your postgres database password in RDS}
    - `TYPEORM_DATABASE`=`postgres` {or your postgres database name in RDS}
**NOTE**: Some AWS-related jobs may take awhile to complete. If a job takes too long, it could cause a timeout. If this is the case, just restart the job and keep your fingers crossed for faster network traffic. If this happens often, you might consider increasing the job timeout as described here(opens in a new tab).

### ToDo
#### 1. Infrastructure Phase
Setting up servers and infrastructure is complicated business. There are many, many moving parts and points of failure. That’s why UdaPeople adopted the IaC (“Infrastructure as Code”) philosophy after their Developer got back from the last DevOps conference. We’ll need a job that executes some CloudFormation templates so that the UdaPeople team never has to worry about a missed deployment checklist item.

In this phase, you will add CircleCI jobs that execute Cloud Formation templates that create infrastructure as well as jobs that execute Ansible Playbooks to configure that newly created infrastructure.

#### 1.a. Create the Infrastructure
Find/create the job named `deploy-infrastructure` in your config file. In this job you will create your infrastructure using the provided CloudFormation templates(opens in a new tab):

- Select a Docker image that supports the AWS CLI, such as `amazon/aws-cli`.

- Checkout code from git, and install tar and gzip

- **Ensure backend infrastructure exist**
    Create a stack, `udapeople-backend-${CIRCLE_WORKFLOW_ID:0:7}` using the *.circleci/files/backend.yml* template file. While deploying the template file, choose a dynamic value for the `--parameter-overrides ID` option, as shown below. The command below (deploying the backend.yml file) will create a SecurityGroup allowing port 22 and port 3030, create an EC2 instance and attach the SecurityGroup, and ensure that the EC2 instance has port 3030 opened up to public traffic.

        ```Use the workflow id to mark your CloudFormation stacks so that you can reference them later on (ex: rollback). 
            aws cloudformation deploy \
                --template-file .circleci/files/backend.yml \
                --stack-name "udapeople-backend-${CIRCLE_WORKFLOW_ID:0:7}" \
                --parameter-overrides ID="${CIRCLE_WORKFLOW_ID:0:7}"  \
                --tags project=udapeople```

- **Ensure frontend infrastructure exist**
    Create a stack, `udapeople-frontend-${CIRCLE_WORKFLOW_ID:0:7}`, using the .circleci/files/frontend.yml template file. It will create a new S3 bucket.

- **AWS Update**: AWS has changed the default settings for new S3 buckets. Accordingly, you need to update the frontend.yml file. Replace the `AccessControl: PublicRead` line with a `PublicAccessBlockConfiguration` shown below.

    ```Resources:
        WebsiteBucket:
            Type: AWS::S3::Bucket
            Properties:
            BucketName: !Sub "udapeople-${ID}"
            # AccessControl: PublicRead
            PublicAccessBlockConfiguration:
                BlockPublicPolicy: false
            WebsiteConfiguration:
                IndexDocument: index.html
                ErrorDocument: 404.html```
- **Add the EC2 instance IP to the Ansible inventory**
    Fetch the public IP of the EC2 instance and append it to the provided Ansible inventory.txt(opens in a new tab) file. Also, persist the modified inventory file to the workspace so that we can use that file in the future jobs.

- Destroy-environment on fail. For this purpose, finish/write the `destroy-environment` command in the `commands` section at the beginning of the config file.

- Add deploy-infrastructure job to the `workflows` section.

- Again, provide a screenshot demonstrating an appropriate job failure (failing for the right reasons). **[SCREENSHOT05]**

- **Fix**: You will have to change the AMI ID and KeyPair name in the backend.yml file, as applicable to your AWS account/region, before you push your changes to Github.

#### 1.b. Configure Infrastructure
Find the job named `configure-infrastructure` in the config file. In this job, you will write code to set up the EC2 intance to run as our backend.

- Select a Docker image that supports Ansible
- Checkout code from git.
- Add the SSH key fingerprint to job so that Ansible will have access to the EC2 instance via SSH.
- Attach the "workspace" to the job so that you have access to all the files you need (e.g. inventory file).

- **Install dependencies**
    Install dependencies for the next step, such as tar, gzip, ansible, or awscli.

- **Configure server**
    Before you write this step, you will have to finish the **Ansible playbook** *.circleci/ansible/configure-server.yml* to set up the backend server. After finishing the Playbook, you will run this Playbook against the EC2 instance that has been programmatically created (inside the CircleCI job). Here are the details for your Playbook: - Use username `ubuntu`.
    - -Configure environment variables for the remote EC2 instance.

    ``` # Get the environment variables from CircleCI and add to the EC2 instance environment:
        - TYPEORM_CONNECTION: "{{ lookup('env', 'TYPEORM_CONNECTION')}}"
        - TYPEORM_ENTITIES: "{{ lookup('env', 'TYPEORM_ENTITIES')}}"
        - TYPEORM_HOST: "{{ lookup('env', 'TYPEORM_HOST')}}"
        - TYPEORM_PORT: 5432
        - TYPEORM_USERNAME: "{{ lookup('env', 'TYPEORM_USERNAME')}}"
        - TYPEORM_PASSWORD: "{{ lookup('env', 'TYPEORM_PASSWORD')}}"
        - TYPEORM_DATABASE: "{{ lookup('env', 'TYPEORM_DATABASE')}}"
        - TYPEORM_MIGRATIONS: "{{ lookup('env', 'TYPEORM_MIGRATIONS')}}"
        - TYPEORM_MIGRATIONS_DIR: "{{ lookup('env', 'TYPEORM_MIGRATIONS_DIR')}}"
    ```
    - Keep your playbook clean and maintainable by using roles. You will need to decide what roles to create and how to split up your code. In one of the roles, - Install Python. - Update/upgrade packages. - Install nodejs, npm, and pm2.

- Once your playbook is ready, you can run it in the CircleCI job as:

        ```cd .circleci/ansible
        ansible-playbook -i inventory.txt configure-server.yml```
- Provide a URL to your public GitHub repository. **[URL01]**
`Tip: Check your CloudFormation console and manually delete the unnecessary stacks which are no longer required.`

### 2. Deploy Phase
Now that the infrastructure is up and running, it’s time to configure for dependencies and move our application files over. UdaPeople used to have this Ops employee in the other building to make the copy every Friday, but now they want to make a full deploy on every single commit. Luckily for UdaPeople, you’re about to add a job that handles this automatically using Ansible. The Ops employee will finally have enough time to catch up on his Netflix playlist.

#### 2.a. Database Migrations
Find the job named `run-migrations` in the config file.

- Select a Docker image that's compatible with NodeJS.
- Checkout code from git and restore the backend cache.
- **Run migrations**:
    Write code that runs database migrations so that new changes are applied. Save some evidence that any new migrations ran. This is useful information if you need to roll back.

    ```- run:
            name: Run migrations
            command: |
                cd backend
                npm install
                ## Run and save the migration output
                npm run migrations > migrations_dump.txt```

    ```Do not copy paste the entire code block above. It may cause the indentation issues in your config file.```
- Send migration status to a 3rd party key-value store:
    The migration output will include "...has been executed successfully" if any new migrations were applied.

- Use `grep` command to check for text that shows that a new migration was applied successfully.
- If true, send a "1" or any other value to denote Success to memstash.io or kvdb.io using a key that is bound to the workflow id like `migration_${CIRCLE_WORKFLOW_ID:0:7}`.
- See an example below:
    ``` - run:
            name: Send migration status to kvdb.io OR memstash.io
            command: |   
                if grep -q "has been executed successfully." ~/project/backend/migrations_dump.txt
                then
                    # If you are using memstash.io, generate the token "7933fe63-4687-4fa1-8426-aa25aa1730ec" on the website
                    curl -H "Content-Type: text/plain" -H "token: 7933fe63-4687-4fa1-8426-aa25aa1730ec" --request PUT --data "1" https://api.memstash.io/values/migration_${CIRCLE_WORKFLOW_ID:0:7}
                    # If you are using kvdb.io, generate the bucket ID "9GE4jRtKznmVKRfvdBABBe" in your local terminal first
                    curl https://kvdb.io/9GE4jRtKznmVKRfvdBABBe/migration_${CIRCLE_WORKFLOW_ID:0:7}  -d '1'
                fi```
    Alternatively, it's alright to use any other key-value storage service.

### 2.b. Deploy Frontend
Find the job named `deploy-frontend` in the config file. In this job, you will write code to prepare the frontend code for distribution and deploy it.

- Select a Docker image that can handle the AWS CLI.
- Attach the workspace from the earlier job.
- **Install dependencies:**
    Install any additional dependencies, such as Python, Ansible, Node, NPM, and AWS CLI. Prefer to do these installations in multiple steps so that you will know where exactly the error occurs, if any.

- **Get backend url:**
    Add the url of the newly created back-end server to the `API_URL` environment variable. This is important to be done before building the front-end in the next step because the build process will take the `API_URL` from the environment and "bake it" (hard-code it) into the front-end code.

    - In a previous job, you created the back-end infrastructure and saved the IP address of the new EC2 instance. This is the IP address you will want to pull out and use here. If the IP address is "1.2.3.4", then the `API_URL` should be `https://1.2.3.4:3030`.
    ```     export BACKEND_IP=$(aws ec2 describe-instances...............)
            export API_URL="http://${BACKEND_IP}:3030"
            echo "API_URL = ${API_URL}"
            echo API_URL="http://${BACKEND_IP}:3030" >> frontend/.env
            cat frontend/.env```
- Deploy frontend objects:
    - Run npm run build one last time so that the backend url gets "baked" into the front-end.
    - Copy the files to your new S3 Bucket using AWS CLI (compiled front-end files can be found in a folder called `./dist`).

    ``` cd frontend
        npm install
        npm run build
        tar -czvf artifact-"${CIRCLE_WORKFLOW_ID:0:7}".tar.gz dist
        aws ```s3 cp dist s3://udapeople-${CIRCLE_WORKFLOW_ID:0:7} --recursive
- Destroy the environment and revert the migration on fail.
- Provide the public URL for your S3 Bucket (aka, your front-end). **[URL02]**

### 2.c. Deploy Backend
Find the job named `deploy-backend` in the config file. In this job, you will write code to deploy the compiled backend files to the EC2 instance.

- Select a Docker image that is compatible with Ansible.
- Add the SSH key fingerprints to the job.
- Attach the "workspace" so that you have access to the previously generated inventory.txt from the deploy-infrastructure job.

- **Install dependencies**
    Install any necessary dependencies, such as tar, gzip, ansible, nodejs, and npm.

- **Deploy backend**
    Use Ansible to copy the files.

    ```cd backend
        npm i
        npm run build
        cd ..
        ## Zip the directory
        tar -C backend -czvf artifact.tar.gz .
        cd .circleci/ansible
        echo "Contents  of the inventory.txt file is -------"
        cat inventory.txt
        ansible-playbook -i inventory.txt deploy-backend.yml```

- **Ansible Playbook**
    Finish the *.circleci/ansible/deploy-backend.yml* and *.circleci/ansible/roles/deploy/tasks/main.yml* files. In the "deploy" role, you can extract the zipped artifact into the EC2 instance, and then start the app.
        ```npm install
        pm2 stop default
        pm2 start npm -- start
        ```
- Destroy the environment and revert the migration on fail.
- Push your changes.

### 3. Smoke Test Phase
All this automated deployment stuff is great, but what if there’s something we didn’t plan for that made it through to production? What if the UdaPeople website is now down due to a runtime bug that our unit tests didn’t catch? Users won’t be able to access their data! This same situation can happen with manual deployments, too. In a manual deployment situation, what’s the first thing you do after you finish deploying? You do a “smoke test” by going to the site and making sure you can still log in or navigate around. You might do a quick `curl` on the backend to make sure it is responding. In an automated scenario, you can do the same thing through code. Let’s add a job to provide the UdaPeople team with a little sanity check.

Find the job named `smoke-test` in your config file. In this job, you will write code to make a simple test on both frontend and backend. Use the suggested tests below or come up with your own.

- Select a lightweight Docker image like one of the Alpine images.
- *Install dependencies*
    Install dependencies like curl, nodejs, npm, or awscli.
- **Backend smoke test:**
    - Retrieve the back-end IP address that you saved in an earlier job.
    - Use curl to hit the back-end API's status endpoint (e.g. https://1.2.3.4:3030/api/status(opens in a new tab))
    - No errors mean a successful test
        ```# Fetch and prepare the BACKEND_IP env var
        export API_URL="http://${BACKEND_IP}:3030"
        echo "${API_URL}"
        if curl "${API_URL}/api/status" | grep "ok"
        then
            return 0
        else
            return 1
        fi```
-  **Frontend smoke test:**
   - Form the front-end url using the workflow id and your AWS region.
   - Check the front-end to make sure it includes a word or two that proves it is working properly.
   - No errors mean a successful test

    ``` URL="http://udapeople-${CIRCLE_WORKFLOW_ID:0:7}.s3-website-us-east-1.amazonaws.com/#/employees"            
        echo ${URL} 
        if curl -s ${URL} | grep "Welcome"
        then
            # Change this to 0 after the job fails
        return 1
        else
        return 1
        fi
        ```
- Provide a screenshot for appropriate failure for the smoke test job. **[SCREENSHOT06]**

### 4. Rollback Phase
Of course, we all hope every pipeline follows the “happy path.” But any experienced UdaPeople developer knows that it’s not always the case. If the smoke test fails, what should we do? The smart thing would be to hit CTRL-Z and undo all our changes. But is it really that easy? It will be once you build the next job!

- At the top of your config file, create a “command(opens in a new tab)” named destroy-environment to remove infrastructure if something goes wrong

    - Trigger rollback jobs if the smoke tests or any following jobs fail.
    - Delete files uploaded to S3.
    - Destroy the current CloudFormation stacks using the same stack names you used when creating the stack earlier (front-end and back-end).
    ```destroy-environment:
    description: Destroy backend and frontend cloudformation stacks given a workflow ID.
    parameters:
        workflow_id:
        type: string      
    steps:
        - run:
            name: Destroy environments
            when: on_fail
            command: |
            echo "Destroying environment: << parameters.workflow_id >> "
            # Your code goes here```
**Note**: Do not copy-paste the yaml code above. It will break the indentation.

- At the top of your config file, create a “command(opens in a new tab)” named revert-migrations to roll back any migrations that were successfully applied during this CI/CD workflow.

    - Trigger rollback jobs if the smoke tests or any following jobs fail.
    - Revert the last migration, if a new migration was applied, on the database to return to the way it was before. You can use that value you saved in MemStash.io(opens in a new tab) OR kvdb.io(opens in a new tab) to know if you should revert any migrations. See an example below:

    ```revert-migrations:
            description: Revert the last migration
            parameters:
                workflow_id:
                    type: string      
            steps:
                - run:
                    name: Revert migrations
                    when: on_fail
                    command: |
                        # Your Memstash or kvdb.io GET URL code goes here
                        # Example: Memstash.io
                        SUCCESS=$(curl -H "token: e52b52de-ee26-41a5-86e8-e8dcc3d995a5" --request GET https://api.memstash.io/values/migration_<< parameters.workflow_id >>)
                        # Example: kvdb.io
                        SUCCESS=$(curl --insecure  https://kvdb.io/9GE4jRtKznmVKRfvdBABBe/migration_<< parameters.workflow_id >>)
                        # Logic for reverting the database state
                        if (( $SUCCESS == 1 ));
                        then
                            cd ~/project/backend
                            npm install
                            npm run migration:revert
                        fi  ```

    ```>**Note**: Do not copy-paste the yaml code above. It will break the indentation.```
- No more jobs should run after these commands have executed.

- Provide a screenshot for a successful rollback after a failed smoke test. **[SCREENSHOT07]**
- Add these rollback commands to other jobs that might fail and need a rollback.

### 5. Promotion Phase
Assuming the smoke test came back clean, we should have a relatively high level of confidence that our deployment was a 99% success. Now’s time for the last 1%. UdaPeople uses the “Blue-Green Deployment Strategy” which means we deployed a second environment or stack next to our existing production stack. Now that we’re sure everything is "A-okay", we can switch from blue to green.

Find the job named `cloudfront-update` in your config file.
- Select a docker image that is compatible with AWS CLI.
- Create code that promotes our new front-end to production.
    - Install any needed dependencies
    - Use a CloudFormation template(opens in a new tab) to change the origin of your CloudFront distribution to the new S3 bucket.

    ```# Change the initial stack name, as applicable to you
        aws cloudformation deploy \
                --template-file .circleci/files/cloudfront.yml \
                --stack-name InitialStack \
                --parameter-overrides WorkflowID="udapeople-${CIRCLE_WORKFLOW_ID:0:7}" \
                --tags project=udapeople```
    - Provide a screenshot of the successful job. **[SCREENSHOT08]**
    - Provide a screenshot showing the evidence of deployed and functioning front-end application in CloudFront (aka, your production front-end). **[URL03_SCREENSHOT]**
    - Provide a screenshot showing the evidence of a healthy backend application. The backend endpoint https://<Public-IP>:3030/api/status should show a healthy response. **[URL04_SCREENSHOT]**


### 6. Cleanup Phase
The UdaPeople finance department likes it when your AWS bills are more or less the same as last month OR trending downward. But, what if all this “Blue-Green” is leaving behind a trail of dead-end production environments? That upward trend probably means no Christmas bonus for the dev team. Let’s make sure everyone at UdaPeople has a Merry Christmas by adding a job to clean up old stacks.

Find the job named `cleanup` in your config file. In this you will write code that deletes the previous S3 bucket and EC2 instance.
    - Query CloudFormation to find out the old stack's workflow id like this:
        ```
        ## Fetch the Old workflow ID
        export OldWorkflowID=$(aws cloudformation \
                list-exports --query "Exports[?Name==\`WorkflowID\`].Value" \
                --no-paginate --output text)
        echo OldWorkflowID: "${OldWorkflowID}"
        echo CIRCLE_WORKFLOW_ID "${CIRCLE_WORKFLOW_ID:0:7}"
        ## Fetch the stack names          
        export STACKS=($(aws cloudformation list-stacks --query "StackSummaries[*].StackName" \
                --stack-status-filter CREATE_COMPLETE --no-paginate --output text)) 
        echo Stack names: "${STACKS[@]}"  
        ```      
- Decide upon teh condition to remove old stacks/s3 bucket
    ```
    ## You can use any condition like:
    ## if [[ "${CIRCLE_WORKFLOW_ID:0:7}" != "${OldWorkflowID}" ]]
    ## if [[ "${OldWorkflowID}" =~ "${STACKS[@]}"  ]]
    if [[ "${CIRCLE_WORKFLOW_ID:0:7}" =~ "${OldWorkflowID}" ]]
    then
    ## your code goes here
    else
    ## your code goes here
    fi
    ```
- Here is an example of deleting the old stacks/s3 bucket
    ```
    aws s3 rm "s3://udapeople-${OldWorkflowID}" --recursive
    aws cloudformation delete-stack --stack-name "udapeople-backend-${OldWorkflowID}"
    aws cloudformation delete-stack --stack-name "udapeople-frontend-${OldWorkflowID}"
    ```
- Provide a screenshot of the successful job. **[SCREENSHOT09]**

### Other Considerations
- Make sure you only run deployment-related jobs on commits to the master branch. Provide screenshot of a build triggered by a non-master commit. It should only run the jobs prior to deployment. **[SCREENSHOT10]**

### Run the application
When you are confident that the application (frontend and backend) are set up correctly and the CloudFront deployment has been switched from old to new, you can try accessing the application using either the CloudFront domain name or the public URL for your S3 Bucket.

### Turn Errors into Sirens
#### Section 4
#### Surface Critical Server Errors for Diagnosis Using Centralized Logging
Errors and unhealthy states are important to know about, wouldn’t you say? But, too often, server errors are silenced by hasty reboots or simply never having an outlet in the first place. If a server has an error in a forest, but no one is there to hear it, did it actually happen? Why is the server in the forest in the first place?

UdaPeople chose Prometheus as a monitoring solution since it is open-source and versatile. Once configured properly, Prometheus will turn our server’s errors into sirens that no one can ignore.

#### Setup - Prometheus Server in AWS EC2
https://youtu.be/PSXrbE54FqQ

- Manually create an EC2 instance and SSH into it.
- Set up Prometheus Server on EC2 following these instructions. https://codewizardly.com/prometheus-on-aws-ec2-part1/
- Configure Prometheus for AWS Service Discovery following these instructions. https://codewizardly.com/prometheus-on-aws-ec2-part3/

```Tip: After makinig edits to the prometheus.yml file in the Prometheus EC2 instance, you can consider restarting the EC2 instance. Consequently, SSH log into the EC2 instance again, and start the Prometheus server.```

### To Do
#### 1. Setup Back-End Monitoring
In order for EC2 server instances to speak to Prometheus, we need to install an “exporter” in each one. Create a job that uses Ansible to go into the EC2 instance and install the exporter.

- Add a section to your back-end configuration job to install the `node_exporter` for Prometheus monitoring. This should be done using Ansible. Your playbook can simulate the steps in this tutorial https://codewizardly.com/prometheus-on-aws-ec2-part2/.
- After deploy, ensure your backend is being discovered by the Prometheus Server.

```Tip: When you see error like: *err="opening storage failed: lock DB directory: resource temporarily unavailable"*, you can consider restarting the Prometheus server.```

```Tip: For your Backend EC2 instance, ensure that the port 9100 is open for inbound connections.```

- Provide a screenshot of a graph of your EC2 instance including available memory, available disk space, and CPU usage. **[SCREENSHOT11]**
    Note that 3 screenshots are required i.e. node free memory, node CPU usage, and node disk usage.

- Provide a screenshot of your Prometheus Server. **[URL05_SCREENSHOT]**
    
### 2. Setup Alerts
Now that Prometheus and our EC2 instance have an open line of communication, we need to set up some alerts. The UdaPeople dev team loves their chat tool and wants to receive an alert in chat when the server starts running out of memory or disk space. Set up a job to make that dream a reality.

- SSH into your Prometheus Server.
- Install and configure AlertManager by following these instructions(https://codewizardly.com/prometheus-on-aws-ec2-part4/). To summarize, the steps would be similar to:

    ```
    mkdir alertmanager
    cd alertmanager
    wget https://github.com/prometheus/alertmanager/releases/download/v0.23.0/alertmanager-0.23.0.linux-amd64.tar.gz
    tar xvzf alertmanager-0.23.0.linux-amd64.tar.gz
    cd alertmanager-0.23.0.linux-amd64/
    ## Edit the alertmanager.yml file
    ./alertmanager --config.file=./alertmanager.yml
    ```
- You can decide if you will use Slack, email, or another messaging service. Our examples are using Slack, but you should feel free to use the messaging service to which you are most accustomed.

```Tip: If you choose Gmail notification, you will have to integrate Google account using the Google's App password(opens in a new tab) rather than your own account password.```

- Set up an alert for low memory, or instance down, or any other condition you can control to intentionally cause an alert.

- Provide a screenshot of an alert that was sent by Prometheus. **[SCREENSHOT12]**





