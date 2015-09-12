---
title: How to deploy middleman with codeship
date: 2015-09-12 15:01 UTC
tags: ruby
cover: codeship.png
lang: en
---

Today I'll explain how to deploy middleman project with codeship

READMORE

## Contexte
I only have one ftp derver to deploy my web site. So first I used the really good gem [middleman-deploy](https://github.com/middleman-contrib/middleman-deploy) and make the settings for ftp. 
I do not want to store the configuration of the ftp in my source. 

## Config
I made a small config file for [codeship](https://codeship.com) :

```yml
FTP_USER: <%= ENV['FTP_USER'] %>
FTP_PASSWORD: <%= ENV['FTP_PASSWORD'] %>
FTP_HOST: <%= ENV['FTP_HOST'] %>
path: /www
```

then I want to the `config.rb` file to use the config 

```ruby
config = YAML.load_file("parameter.yml")
config.map do |key, value|
  if ENV[key.to_s]
    value = ENV[key]
  end
  config[key] = value
end

activate :deploy do |deploy|
  deploy.method = :ftp
  deploy.host = config['FTP_HOST']
  deploy.user = config['FTP_USER']
  deploy.password = config['FTP_PASSWORD']
  deploy.path = config['path']
  deploy.build_before = true # default: false
end
```

## Codeship

In codeship I make sure the config is available and the right env variable are set

```bash
rvm use 2.2.0 --install
mv parameter.codeship.yml parameter.yml
bundle install
```

Test of the build:
```bash
bundle exec middleman build
```

And then for the deployment process I use the command:

```bash
export FTP_USER=your-user-ftp
export FTP_PASSWORD=your-ftp-password
export FTP_HOST=ftp-host
bundle exec middleman deploy
```

And just like that, each time you push on your master branch you also automatically deploy your website. 



