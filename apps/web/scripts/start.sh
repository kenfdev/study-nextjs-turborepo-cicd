#!/bin/sh

# Replace runtime env vars and start next server
sh apps/web/scripts/replace-vars.sh && 
node apps/web/server.js