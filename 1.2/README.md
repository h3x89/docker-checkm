# Docker-Check_MK
https://github.com/uvwxy/docker-checkmk

Unofficial docker container of Check_MK

####  Manual Build
Build the image locally

```
git clone https://github.com/uvwxy/docker-checkmk.git
cd docker-checkmk
make
```

#### Run

```
docker run -p 81:80 uvwxy/checkmk
```

Open in a browser:
 `http://localhost:81/check_mk/` with `user=admin` and `password=admin`


 # Default vars
 /usr/share/check_mk/web/htdocs/defaults.py
