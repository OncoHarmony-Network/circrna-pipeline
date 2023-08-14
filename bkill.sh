#!/usr/bin/env bash

pat=$1
ps -ef | grep ${pat} | grep -v grep | awk '{print $2}' | xargs kill -s 9
