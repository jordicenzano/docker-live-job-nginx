# docker-live-job-nginx
Simple container with nginx+rtmp module that allows you to test a simple live streaming transmux scenario (RTMP -> HLS)

# Introduction
Containers are not the best options to keep TCP persistent connections open forever. But this has been develloped as a simple POC to see what the nginx + RTMP module can do.

# Build
- Ensure you have [docker](https://www.docker.com/) in your system
- Just type `make`, or pull the container from DockerHub (`docker pull jcenzano/livejob`)

# Test
- Run the container locally `make run`
- The container will expose ports 8080 (HLS) and 1935 (RTMP)
- Create a RTMP stream pointing to `rtmp://localhost:1935/live/streamname` (You can use wirecast, ffmpeg, etc)
- Using any HLS player (Safari, VLC, etc) read the following URL `http://localhost:8080/hls/streamname.m3u8`

THAT'S IT!!

# Thanks
- https://github.com/arut/nginx-rtmp-module
- https://github.com/tiangolo/nginx-rtmp-docker