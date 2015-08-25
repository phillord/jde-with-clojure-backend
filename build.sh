#!/bin/sh

cd jdee-nrepl
lein install
cd ..
cd jdee-maven-nrepl
mvn install
cd ..
cd jdee-live
cask package
cd ..
cd jdee-sample/
mvn install
cd ..
