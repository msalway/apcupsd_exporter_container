#!/bin/bash

podman build --arch arm64 --format docker -t apcupsd-exporter .
