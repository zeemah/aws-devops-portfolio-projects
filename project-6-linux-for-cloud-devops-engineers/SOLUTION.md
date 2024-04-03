## Deployment solution
1. Login to the server as super user `sudo su -`
    1. Create users and set passwords – user1, user2, user3 
    create user1 `useradd user1`
    set password `passwd user1`
    **Note this prompts you to type in the new password for the user**
    create user2 `useradd user2`
    set password `passwd user2`
    create user3 `useradd user3`
    set password `passwd user3`

    **Note to list users user `cat /etc/passwd`**

    2. Create Groups – devops, aws
    - command `groupadd devops`
    - command `groupadd aws`

    **Note to list groups `cat /etc/group`**  

    3. Change primary group of user2, user3 to ‘devops’ group
    - command `usermod -g devops user2`
    - command `usermod -g devops user3`

    4. Add ‘aws’ group as secondary group to the ‘user1’
    command `usermod -G aws user1`

    ![file structure]()

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
    2. Change to “/dir2/dir1/dir2/dir10” directory and create file “/opt/dir14/dir10/f1” using relative path method. **start here tomorrow**
    ```
    sudo cd /dir2/dir1/dir2/dir10
    sudo touch ../../../opt/dir14/dir10/f1
    ```
    3. Move the file from “/opt/dir14/dir10/f1” to  user1 home directory
    ```
    sudo mv /opt/dir14/dir10/f1 /home/user1/
    ```
    4. Delete the directory recursively “/dir4”
    5. Delete all child files and directories under “/opt/dir14” using single command.
    6. Write this text “Linux assessment for an DevOps Engineer!! Learn with Fun!!” to the /f3 file and save it.