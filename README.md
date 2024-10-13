#Spotify Playlist using Terraform

##Project 1 : Creating SPotify playlist using terraform#

###Pre-requisite:#
1. Terraform Installed: Ensure Terraform is installed on your machine.
2. Docker Installed: Make sure Docker is installed and running.
3. Spotify Account: You need a Spotify account (without premium access)
4. Spotify Developer Account: Register and create an application to get the Client ID and Client Secret.
5. Spotify Provider for Terraform: Install and configure the Spotify provider for Terraform.
6. VS Code Editor: Recommended for editing Terraform files.

###To Create API
docker run --rm --it -p 27228:27228 --env-file .env ghcr.io/conradludgate/spotify-auth-proxy
Keep it running else the terraform apply command will fail to authenticate
