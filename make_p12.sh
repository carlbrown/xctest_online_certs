#!/bin/bash

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RELATIVE_SCRIPT_DIR="${SCRIPT_DIR#$HOME/}"

openssl pkcs12 -export -out xctest.online.p12 -inkey xctest.online.key -in xctest.online.crt -certfile chain.pem -password pass:xctest.online
