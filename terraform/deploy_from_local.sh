#!/usr/bin/env bash

make ENV=root initall 
make ENV=root planall

make ENV=security initall
make ENV=security planall

make ENV=dev initall
make ENV=dev planall

make ENV=preprod initall
make ENV=preprod planall

make ENV=prod initall
make ENV=prod planall