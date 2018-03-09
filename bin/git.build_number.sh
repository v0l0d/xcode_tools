#!/bin/bash

git rev-list --count HEAD

#https://stackoverflow.com/questions/4120001/what-is-the-git-equivalent-for-revision-number
# this one didn't work well with build that has been merged after other commits, thou it shows previos version
#git rev-list --count --first-parent HEAD
