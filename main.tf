terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 4.1.0"
    }
  }

    backend "local" {
      
  }
  
}

variable "HEROKU_EMAIL" {
  description = "The heroku account email"
  type        = string
}
variable "HEROKU_API_KEY" {
  description = "The heroku account api key"
  type        = string
}

provider "heroku" {
  email   = var.HEROKU_EMAIL
  api_key = var.HEROKU_API_KEY
}


resource "heroku_app" "default" {
  name   = "deploying-fullstack-codecademy"
  region = "us"
  stack = "container"
}

resource "heroku_addon" "database" {
  app  = heroku_app.default.name
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_build" "default" {
  app  = heroku_app.default.id
  
  source {
    # This app uses a community buildpack, set it in `buildpacks` above.
    
    path= "."
  }
}

resource "heroku_formation" "default" {
  app        = heroku_app.default.id
  type       = "web"
  quantity   = 1
  size       = "Standard-1x"
  depends_on = [heroku_build.default]
}


