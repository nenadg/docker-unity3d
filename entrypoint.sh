#!/bin/bash
mkdir -p ~/.vnc && \
 x11vnc -storepasswd $VNC_PASSWORD ~/.vnc/passwd && \
 x11vnc -forever -usepw -create