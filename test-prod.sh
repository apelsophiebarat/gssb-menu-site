#!/bin/sh
export NODE_ENV='production'
npm install --production
docpad run

