# GoDev-Docker

![logo](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/GoLanguage_Logo_2018-04-26_BlackWhite.svg/1200px-GoLanguage_Logo_2018-04-26_BlackWhite.svg.png)

## A Containerized, Fedora-powered Go Development Environment

[![Build Status](https://travis-ci.com/VltraHeaven/godev-docker.svg?branch=master)](https://travis-ci.com/VltraHeaven/godev-docker)

I got tired of encountering weird hiccups while developing and testing on my host so I made this container image so that I can develop in a clean environment and be able to quickly trash it when I invariably screw something up. It's build on the Fedora container image and has Go Modules activated by default. I suggest creating an alternate go project folder (named 'go-projects' in the following instructions) in your home directory prior to running this image. 

## Building the Container Image
```sh
$ git pull https://github.com/VltraHeaven/godev-docker
$ cd ./godev-docker
$ docker build -t godev-docker .
```
## Alternatively, you can pull the image from DockerHub
```sh
$ docker pull vltraheaven/godev-docker
```

## Running the Container
```sh
$ docker run -it --rm -v $HOME/go-projects:/home/golang/go -name godev-docker godev-docker
```
> The Dockerfile creates a user with the username 'golang' and UID|GID of '1000', adds the account as a password-less sudoer and starts the container within the context of this user. Feel free to change any of these settings at your discrection.
