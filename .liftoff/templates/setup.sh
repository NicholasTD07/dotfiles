#!/usr/bin/env bash

bundle install && carthage update  --platform all --use-ssh --use-submodules --no-use-binaries
