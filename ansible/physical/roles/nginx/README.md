nginx
=====

Install, configure and start nginx, and install static website files.

Make the following websites available:

* http://www.backtobasicsreading.com
* http://www.ichimonji10.name
* https://subsonic.ichimonji10.name
* https://syncthing.ichimonji10.name
* https://transmission.ichimonji10.name

Variables:

* `nginx_ssl_files`: Optional. If omitted, certain tasks are skipped. A list of
  paths to local SSL certificates and certificate keys. These files are
  installed in `/etc/nginx/ssl`.
