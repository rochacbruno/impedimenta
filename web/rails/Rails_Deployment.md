Rails Deployment
================

A good overview of deployment methods can be found
[here](http://www.modrails.com/documentation/Architectural%20overview.html).
The following is a brief summary of the relevant bits, with a focus on Rails
2.x and 3.x deployment.

Rails 2.x
---------

The recommended method for daemonizing Rails 2.x applications is with Mongrel.
Mongrel is a web server, and it can accept HTTP requests directly. Typically, a
proper web server receives requests from the outside world and distributes
those requests to Mongrel instances.

Mongrel development has stopped, and Mongrel should not be used for Rails 3.x
applications.

Rails 3.x
---------

The recommended method for daemonizing Rails 3.x applicaitons is with Phusion
Passenger. Phusion Passenger can be run in standalone mode or as a module.

### Standalone

In standalone mode, Phusion Passenger accepts HTTP requests directly. This is
similar to Mongrel's method of interfacing with the outside world.

### Module

Phusion Passenger can be integrated directly into a web server using a web
server module. In this case, the web server also acts as the application
server. Modules currently exist for Apache and Nginx.
