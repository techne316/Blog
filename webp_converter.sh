#!/bin/sh
cd ./static/img
for IMAGE in `ls -a | grep  -e "unsplash"`
do
	cwebp ${IMAGE} -o ${IMAGE}.webp
done