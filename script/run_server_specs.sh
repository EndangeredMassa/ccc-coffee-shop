#!/bin/sh

echo "Starting application..."
./start_application.sh
sleep 1
./node_modules/jessie/bin/jessie spec/server -f nested
echo "Stopping application..."
./stop_application.sh
echo "Done."

