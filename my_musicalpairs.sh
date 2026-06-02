#!/bin/bash
ls ./students | cut -d'.' -f1 | shuf --random-source=<(echo "%day") | paste - -