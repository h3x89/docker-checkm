docker kill centos;docker rm centos
docker build -t rkubis/centos:latest .
docker run -dit \
  --name centos \
  -p 80:5000 \
  -v "$(pwd)"/check_mk:/opt/omd/versions/1.4.0p19.cre/skel/etc/check_mk/test_mount \
   rkubis/centos:latest
docker exec -it centos bash
