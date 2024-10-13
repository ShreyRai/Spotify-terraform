#Spotify Playlist using Terraform

#Project 1 : Creating SPotify playlist using terraform#

#Pre-requisite:#
1. Terraform Installed: Ensure Terraform is installed on your machine.
2. Docker Installed: Make sure Docker is installed and running.
3. Spotify Account: You need a Spotify account (without premium access)
4. Spotify Developer Account: Register and create an application to get the Client ID and Client Secret.
5. Spotify Provider for Terraform: Install and configure the Spotify provider for Terraform.
6. VS Code Editor: Recommended for editing Terraform files.

#Step1:#
Create a terraform folder and some files into it
files should be:
provider.tf
variables.tf
terraform.tfvars
main.tf 
.env

To create provider.tf file. Go to terraform.providers site > in providers search for spotify provider and select conradludgate
selct use provider > copy and paste the code
terraform {
  required_providers {
    spotify = {
      source = "conradludgate/spotify"
      version = "0.2.7" or "~> 0.2.7"
    }
  }
}

provider "spotify" {
   ##Configuration options##
  api_key = <api_key_generated_in_step_3> <use variables> #
}

to find API key we will have to use following command after step 2:
sudo docker run --rm -it -p 27228:27228 --env-file .env ghcr.io/conradludgate/spotify-auth-proxy
But before this we will need a few things

#Step2: Create a developer and user account on spotify#
Create a dev account > click on user name on top right corner > create app > give name and title and skip website section.
on URL section give :  http://localhost:27228/spotify_callback

Now click on proceed and copy client id and secret: 
SPOTIFY_CLIENT_ID=81462e2ed613455289793e5b8df000c3
SPOTIFY_CLIENT_SECRET=955114cbc076493f982dbf3186e7a3df

Put this details in .env file

#Step3: Now run the docker command to get the API key#
docker run --rm -it -p 27228:27228 --env-file .env ghcr.io/conradludgate/spotify-auth-proxy

You have to keep it running, if you run this in backgroung you will not get API key and url to authorize
just keep it running in foreground and copy the API key and paste in provider.tf file

Example:
lucky@ubuntux:~/Documents/terraform/spotify$ docker run --rm -it -p 27228:27228 --env-file .env ghcr.io/conradludgate/spotify-auth-proxy
APIKey:   V0S1o4Hjhf0Wnex3--9cWeJXt_nrhI79tWM9bAi0iRyruN1_tlMp46PExYNEtjC2
Auth URL: http://localhost:27228/authorize?token=KwxeG5Lr1CJwQmONW4iUZNgWxQmsLJG_R3_sSo5t82gQoHycf6v6SqRtmphS5Q7q
Authorization successful

#Step 4: put above api key in tfvars file and mention the var in variable.tf file#

Here is how your files should look:
<<<<<<<<<<<<<<<<<<<<<<<<  .env >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SPOTIFY_CLIENT_ID=81462e2ed613455289793e5b8df000c3
SPOTIFY_CLIENT_SECRET=955114cbc076493f982dbf3186e7a3df

<<<<<<<<<<<<<<<<<<<<<<<<  terraform.tfvars >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
api_key=V0S1o4Hjhf0Wnex3--9cWeJXt_nrhI79tWM9bAi0iRyruN1_tlMp46PExYNEtjC2

variables.tf
variable "api_key" {
    type = string
}

<<<<<<<<<<<<<<<<<<<<<<<<  provider.tf >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
terraform {
  required_providers {
    spotify = {
      source = "conradludgate/spotify"
      version = "~> 0.2.7"
    }
  }
}

provider "spotify" {
  # Configuration options
  api_key = var.api_key
}

<<<<<<<<<<<<<<<<<<<<<<<< main.tf >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
resource "spotify_playlist" "Rock" {
    name = "Rock" #playlist name
    tracks = ["7k3jpyYPnVnbO0p7iejWxL", "6fABlNfAOylt7ZxfX8K1XL"] #SPotify have ids for every song, mention the ids of songs you want into your playlist.
}

these ids are for saddahaq and rock on!! song.

#Step 5: Run #
terraform init
terraform apply
if such problem occurs then your docker container is not running and you may have to run it again.
Error:
lucky@ubuntux:~/Documents/terraform/spotify$ terraform apply
╷
│ Error: dial tcp 127.0.0.1:27228: connect: connection refused
│ 
│   with provider["registry.terraform.io/conradludgate/spotify"],
│   on provider.tf line 10, in provider "spotify":
│   10: provider "spotify" {
