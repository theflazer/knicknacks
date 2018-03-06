#!/bin/bash
cd $HOME && source staging-config && cd champsys &&  pm2 start server/app.js --name "Champsys_NS"
