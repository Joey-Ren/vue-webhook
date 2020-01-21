#!/bin/bash

WORK_PATH = '/home/baseuser/vue-front'
cd $WORK_PATH
echo "先清除老代码"
git reset --hard origin/master
git clean -f
echo "拉取最新代码"
git pull origin master
echo "编译"
npm run build
echo "开始执行构建"
docker build -t vue-back:10 .
echo "同志旧容器并删除旧容器"
docker stop vue-back-container
docker rm vue-back-container
echo "启动新容器"
docker container run -p 80:80 --name vue-front-container -d vue-back
