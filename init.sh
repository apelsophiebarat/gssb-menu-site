#!/bin/sh
npm install
grunt bower:install
docpad generate
