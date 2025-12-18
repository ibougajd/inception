#!/bin/bash

npm install -g http-server

exec http-server /var/www/html -p 1337
