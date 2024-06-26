## Deployment solution
1. Login to the server as super user `sudo su -`
    1. Create users and set passwords – user1, user2, user3 
    - create user1 `useradd user1`
    - set password `passwd user1`
    **Note this prompts you to type in the new password for the user**
    - create user2 `useradd user2`
    - set password `passwd user2`
    - create user3 `useradd user3`
    - set password `passwd user3`

    **Note to list users user `cat /etc/passwd`**

    2. Create Groups – devops, aws
    - command `groupadd devops`
    - command `groupadd aws`

    **Note to list groups `cat /etc/group`**  

    3. Change primary group of user2, user3 to ‘devops’ group
    - command `usermod -g devops user2`
    - command `usermod -g devops user3`

    4. Add ‘aws’ group as secondary group to the ‘user1’
    - command `usermod -G aws user1`

    ![file structure](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-6-linux-for-cloud-devops-engineers/linux.png)

    5. Create the file and directory structure shown in the above diagram.
    - command to get to root directory `cd ~`
    - create home `mkdir home`
    - create /dir1 and create f1 simultaneously `mkdir dir1 && touch /dir1/f1`
    - create /dir2/dir1/dir2/dir10  and /dir2/dir1/dir2/f3
        ```
        mkdir dir2
        cd dir2
        mkdir dir1
        cd dir1
        mkdir dir2
        mkdir dir10 && touch f3
        # use `ls -l` to view files and folders
        cd ~ #to go back to root
        ```
    - create /dir3/dir11
        ```
        mkdir dir3 && cd dir3
        mkdir dir11
        cd ~
        ```
    - create /dir4/dir12/f5 and /dir4/dir12/f4
        ```
        mkdir dir4 && cd dir4
        mkdir dir12 && cd dir12
        touch f5 && f4
        cd ~
        ```
    - create /dir5/dir13
        ```
        mkdir dir5 && cd dir5
        mkdir dir13
        cd ~
        ```
    - create /dir6 `mkdir dir6`
    - create /dir7/dir10 and /dir7/f3
        ```
        mkdir dir7 && cd dir7
        mkdir dir10 && touch f3
        cd ~
        ```
    - create /dir8/dir9
        ```
        mkdir dir8 && cd dir8
        mkdir dir9
        cd ~
        ```
    - create f1 `touch f1`
    - create f2 `touch f2`
    - create /opt/dir14/dir10 && /opt/dir14/f3
        ```
        mkdir opt && cd opt
        mkdir dir14 && cd dir14
        mkdir dir10 && touch f3
        ```
    6. Change group of /dir1, /dir7/dir10, /f2 to “devops” group
    - command to change all at once `chgrp -R devops dir1 dir7/dir10 f2`
    7. Change ownership of /dir1, /dir7/dir10, /f2 to “user1” user.
    - command to change all at once `chown -R user1 dir1 dir7/dir10 f2`

2. Login as user1 and perform below 
    - command `su user1`
    1. Create users and set passwords – user4, user5
        ```
        sudo  useradd user4
        sudo passwd user4  #to propmt password input do same for user5
        ```
        **Note: One challenge I faced here is user1 isn't a sudoer. As such you have to switch to root user using the `su -` command to add user1 on the sudoer list. Do this:**

            ```
            su -
            visudo
            user1 ALL=(ALL) ALL
            ```
        **Then save ane exit the file editor. After this, user1 will have sudoer privileges, switch back from root to user1**
    2. Create Groups – app, database
        ```
        groupadd  app
        groupadd database
        ```

3. Login as ‘user4’ and perform below
    **Note: add user4 to sudoer list using root user. The switch to user4**
    1. Create directory – /dir6/dir4
    ```
    sudo mkdir dir6/dir4
    ```
    2. Create file – /f3
    ```
    sudo touch f3
    ```
    3. Move the file from “/dir1/f1” to “/dir2/dir1/dir2”
    ```
    sudo mv dir1/f1 dir2/dir1/dir2
    ```
    4. Rename the file ‘/f2′ to /f4’
    ```
    sudo mv f2 f4
    ```
4. Login as ‘user1’ and perform below
    1. Create directory – “/home/user2/dir1”
    ```
    sudo  mkdir home/user2/dir1
    ```
    2. Change to “/dir2/dir1/dir2/dir10” directory and create file “/opt/dir14/dir10/f1” using relative path method.
    ```
    sudo cd /dir2/dir1/dir2/dir10
    sudo mkdir ../../../opt/dir14
    sudo mkdir ../../../opt/dir14/dir10
    sudo touch ../../../opt/dir14/dir10/f1
    ```

    3. Move the file from “/opt/dir14/dir10/f1” to  user1 home directory
    ```
    sudo mv /opt/dir14/dir10/f1 /home/user1/
    ```
    4. Delete the directory recursively “/dir4”
    ```
    sudo rm -r /dir4
    ```
    5. Delete all child files and directories under “/opt/dir14” using single command.
    ```
    sudo rm -r /opt/dir14/*
    ```
    6. Write this text “Linux assessment for an DevOps Engineer!! Learn with Fun!!” to the /f3 file and save it.
    ```
    echo "Linux assessment for an DevOps Engineer!! Learn with Fun!!" > /f3
    ```

5. Login as ‘user2’ 
- command `sudo su user2` 
    1. Create file “/dir1/f2”
    ```
    sudo mkdir  /dir1 && cd /dir1
    sudo touch f2
    ```
    2. Delete /dir6
    ```
    sudo rm -r /dir6
    ```
    3. Delete /dir8
    ```
    sudo rm -r /dir8
    ```
    4. Replace the “DevOps” text to “devops” in the /f3 file without using  editor.
    ```
    sudo sed -i 's/DevOps/devops/g' /f3
    ```
    5. Using Vi-Editor copy the line1 and paste 10 times in the file /f3.
    - open the file in vim editor `sudo vi f3`
    - Move the cursor to the first line.
    - Copy the line using `yy` (yank) command.
    - Move the cursor to where you want to paste the copied line (e.g., 10 lines down).
    - Paste the copied line using the `p` command.
    - Repeat steps 4 and 5 as necessary to paste the line multiple times.
    - Save and exit the file by pressing `Esc` to ensure you're in command mode, then typing `:wq` (write and quit) and pressing Enter.

    6. Search for the pattern “Engineer” and replace with “engineer” in the file /f3 using single command.
    ```
    sudo sed -i 's/Engineer/engineer/g' /f3
    ```
    7. Delete /f3
    ```
    sudo rm f3
    ```
6. Login as ‘root’ user  `sudo su -`
    1. Search for the file name ‘f3’ in the server and list all absolute  paths where f3 file is found.
    ```
    sudo find / -type f -name 'f3' 2>/dev/null
    ```
    2. Show the count of the number of files in the directory ‘/’
    ```
    sudo find / -type f | wc -l
    ```
    3. Print last line of the file ‘/etc/passwd’
    ```
    sudo tail -n 1 /etc/passwd
    ```
7. Login to AWS and create 5GB EBS volume in the same AZ of the EC2 instance and attach EBS volume to the Instance.
    ![ebs volume](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-6-linux-for-cloud-devops-engineers/ebs-on-terminal.png)
8. Login as ‘root’user `sudo su -`
    1. Create File System on the new EBS volume attached in the previous step
    ![ebs volume](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-6-linux-for-cloud-devops-engineers/ebs-attached.png)
    ![ebs volume](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-6-linux-for-cloud-devops-engineers/ebs-mkfs.png)

    ```
    lsblk # to list all the  block devices
    mkfs -t ext4 /dev/xvdb #to create the file system
    ```

    2. Mount the File System on /data directory

    ```
    mkdir /data # to create a directory where you want to mount the ebs volume
    mount /dev/xvdb /data #to mount the ew volume 
    ```
    3. Verify File System utilization using ‘df -h’ command – This command must show /data file system
    ![ebs volume](https://github.com/zeemah/aws-devops-portfolio-projects/blob/main/project-6-linux-for-cloud-devops-engineers/ebs-mount-df-h.png)
    ```
    df -h /data  #or just `df -h`
    ```
    4. Create file ‘f1’ in the /data file system.
    ```
    touch /data/f1
    ls /data #to confirm the file was created
    ```

9. Login as ‘user5’ `sudo su user5`
    1. Delete /dir1 `sudo rm /dir1`
    2. Delete /dir2 `sudo rm /dir2`
    3. Delete /dir3 `sudo rm /dir3`
    4. Delete /dir5 `sudo rm /dir5`
    5. Delete /dir7 `sudo rm /dir7`
    6. Delete /f1 & /f4 `sudo rm /f1 /f4`
    7. Delete /opt/dir14     `sudo rm -r /opt/dir14`

10. Logins as ‘root’ user `sudo su -`
    1. Delete users – ‘user1, user2, user3, user4, user5’
    ```
    sudo userdel user1
    sudo userdel user2
    sudo userdel user3
    sudo userdel user4
    sudo userdel user5
    ```
    2. Delete groups – app, aws, database, devops
    ```
    sudo groupdel app
    sudo groupdel aws
    sudo groupdel database
    sudo groupdel devops
    ```
    3. Delete home directories  of all users ‘user1, user2, user3, user4, user5’ if any exists still.
    ```
    sudo userdel -r user1
    sudo userdel -r user2
    sudo userdel -r user3
    sudo userdel -r user4
    sudo userdel -r user5
    ```
    4. Unmount /data file system
    ```
    sudo umount /data
    ```
    5. Delete /data directory
    ```
    sudo rm -r /data
    ```
11. Login to AWS and detach EBS volume to the EC2 Instance and delete the volume and then terminate EC2 instance.
