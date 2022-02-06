#!/bin/bash


## exa
### https://the.exa.website/
### Documentation: https://the.exa.website/docs
### Building from source: https://the.exa.website/install/source

## Dependency on Rust, libgit2 and CMake
git clone https://github.com/ogham/exa.git /home/owen/source/exa
/home/owen/source/exa/cargo build --release 
## Copy binary to directory in $PATH
