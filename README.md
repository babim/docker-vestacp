# VestaCP
fork from https://github.com/niiknow/vestacp
The ultimate control panel with docker (thanks lagun4ik and niiknow for a great start)

What's included?
* ubuntu 16.04 lts + Vesta 0.9.8-17
* nginx (proxy) -> apache2 -> php7.1 - high performance and flexible implementation
* ssh/sftp, letsencrypt, memcached, redis, MariaDB 10.1, postgresql 9.5, nodejs 8.x, golang 1.9, openvpn, mongodb, couchdb
* folder redirection for data persistence and automatic daily backup provided by VestaCP
* DNS, named, dovecot/roundcube, spamassassin, clamav, fail2ban, etc... -- disabled by default

Run this image:
```
mkdir -p /opt/vestacp/{vesta,home,backup}

docker run -d --restart=always \
-p 2222:22 -p 80:80 -p 443:443 -p 3306:3306 -p 5432:5432 -p 8083:8083 \
-v /opt/vestacp/vesta:/vesta -v /opt/vestacp/home:/home -v /opt/vestacp/backup:/backup \
babim/vestacp
```

## Volumes
/vesta  -- configurations

/home   -- users data

/backup -- users backup

## Authorization
Login: admin Password: Password

## SSH for FTP
FTP was not installed on purpose because it's not secure.  Use SFTP instead on the 2222 port.  Disable ssh if you don't really need it and use the Vesta FileManager plugin.  Also, make sure you change the user shell in the Vesta panel in order to use ssh.

## todo/done
- [x] redirected customizable config folders to /vesta, exclude /home.  Home has been setup to be it's own volume.  Do not try to redirect the home folder.  It's like opening a big can of worms.  There are all kind of breaking issues with having home as a symbolic link: Vesta FileManager breaking, Apache and Nginx breaking, SSL breaking, and so on...
- [x] Use incrond to watch /etc/{passwd,shadow,gshadow,group} and sync to /backup/.etc so remember to attach the backup volume if you want to save password across restart.
- [x] AWS CLI has been installed to simplify your backup lifestyle.  You just need to setup a cron on VestaCP.
- [x] Update *index.html* to remove reference to VestaCP from default site for security.
- [x] **Dovecot/roundcube email, phpmyadmin, phppgadmin, and DNS services** are disabled by default.  Look at /home/admin/bin/my-startup.sh for instruction on how to re-enable these services.
- [x] To enable iptables firewall, run docker with: --cap-add=NET_ADMIN --cap-add=NET_RAW

### misc/tested/verified
- [x] ssh/sftp, nginx, apache2, php7.0 + v8js 
- [x] log viewing in Vesta
- [x] backup and restore
- [x] Vesta FileManager
- [x] Letsencrypt
- [x] Sending/outgoing email, dovecot
- [x] phpmyadmin, phppgadmin
- [x] Redis, Memcached
- [x] nodejs, golang
- [x] MariaDB/MySQL, Postgresql, Mongodb
- [x] Fix postgresql backup and restore issue ref - https://github.com/serghey-rodin/vesta/issues/913
- [x] add incron to monitor and immediately backup /etc/{passwd,shadow,gshadow,group}
- [ ] java, dotnet
- [ ] openvpn
- [x] nginx pagespeed module
- [x] multiple php{5.6,7.0,7.1} fcgi templates
- [x] redirect awstats

### known issues
- [ ] MariaDB password is not saved across backup and restore.  After you restore, go to VESTA DB admin UI and update the password.

### your todo
- [ ] I recommend the following:

1. Since this is Docker, you can run as many services as you want but only expose request port.
2. Change the default/initial *admin* password for security purpose.
3. Instead of using the *admin* acccount, consider creating a different/separate credentials for different website/service.  This will make it easier for backup and recovery; especially, when you need to move the user to a different installation.

### extra
If you use this Docker for hosting and allow your user to login, I also recommend installing maldetect on the docker host to scan the /home volume.

Enjoy!!!
