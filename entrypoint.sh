#!/bin/bash

echo "The value of the variable SERVE_PATH is $SERVE_PATH"
echo "Using this as directory to serve the webdav service"
echo ""

mega-webdav $SERVE_PATH
