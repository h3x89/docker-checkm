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


# Problems
https://www.google.pl/search?q=check_mk+passive+checks+pending&oq=check_mk+passive+checks+pending&aqs=chrome.0.69i59j69i60l2.6195j0j7&sourceid=chrome&ie=UTF-8
http://forum.shinken-monitoring.org/threads/641-passive-check-with-check_mk-are-always-in-a-pending-state

Could I compare that with:
https://github.com/h3x89/nagios/blob/master/install_nagios.sh

nagios.cmd missing - I SHOULD FIX SUTUP SCRIPT FOR CHECK MK
https://www.google.pl/search?ei=zGMwWqmoOKmL6ATy-5SYCQ&q=nagios.cmd+missing&oq=nagios.cmd+mis&gs_l=psy-ab.3.0.0i203k1j0i22i30k1.6152.7608.0.8520.5.5.0.0.0.0.152.503.4j1.5.0....0...1c.1.64.psy-ab..0.5.501...0i30k1.0.XFLVUuCK1jE
https://support.nagios.com/forum/viewtopic.php?f=7&t=11762
