# docker kill $(docker ps -aq);docker rm $(docker ps -aq)
docker kill checkmk12;docker rm checkmk12
docker build -t rkubis/check-mk-1-2 . ; docker run -d --name checkmk12 -p 81:80 rkubis/check-mk-1-2
docker exec -it checkmk12 bash
