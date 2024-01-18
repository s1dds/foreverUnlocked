#!/bin/bash

echo "Building package for ROOTFUL Jailbreak"

make clean
make package FINALPACKAGE=1

echo "Building package for ROOTLESS Jailbreak"

make clean
make package FINALPACKAGE=1 THEOS_PACKAGE_SCHEME=rootless
