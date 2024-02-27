#!/bin/bash

echo "The value of the variable SERVE_PATH is $SERVE_PATH"
echo "Using this as directory to serve the webdav service"
echo ""
echo "The value of the variable PORT is $PORT"
echo "Using this as port to serve the webdav service"

mega-webdav --port=$PORT $SERVE_PATH
