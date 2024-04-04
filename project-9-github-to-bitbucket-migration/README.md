# GitHut to BitBucket Migration
## Goal
Currently application code is staged into GitHub repository and the requirement is to migrate the code to Bit Bucket repository.

## Pre-Requisites
1. Github Repo: https://github.com/dptrealtime/java-login-app.git
2. Create two Bitbucket  accounts to follow the best practices (Developer1 & Developer2 accounts)
3. Create private Bitbucket repository and add Developer1 and Developer2 as collaborators. 

## Migration
1. Clone GitHub repository
2. Clone Bitbucket repository as Developer1
3. Migrate the code from Github repository (local master) to Bitbucket repository (local master)
4. Follow branching strategy and commit the code to “feature” branch of Bitbucket repository.
5. Raise Pull Request to merge the code from Feature branch to Master branch and add Developer2 as reviewer.
6. Login to Bitbucket as Developer2 then approve and merge the PR using “no fast forward”  merge strategy.

## Verification
1. Verify that the code is now showing in the Bitbucket repo.
**Note:** Explore various other options to migrate the code from Github to Bitbucket and add the possibilities in the comments.
