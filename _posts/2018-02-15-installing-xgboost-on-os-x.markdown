---
layout: post
title: "Installing XGBoost on OS X"
date: 2018-02-15 18:30:40 -0700
comments: true
---
Today I went to install [XGBoost](https://github.com/dmlc/xgboost) on OS X Sierra and ran into some issues. Here's how I fixed it.
<!--more-->

```bash
git clone --recursive https://github.com/dmlc/xgboost
brew install gcc
export CC=/usr/local/bin/gcc-7
export CXX=/usr/local/bin/g++-7
cd xgboost
cp make/config.mk ./config.mk
make -j4
cd python-package
python3 setup.py install
```
