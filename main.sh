#!/usr/bin/env bash

ruby downloader.rb
time ruby main.rb
time ruby main.rb -g
mkdir -p profile
ruby main.rb    --out profile/numo-mnist.dump
ruby main.rb -g --out profile/cumo-mnist.dump
stackprof profile/numo-mnist.dump
stackprof profile/cumo-mnist.dump
