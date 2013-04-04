Rails 2.3 Quick Start
=====================

This guide has been tested with Rails v2.3.18. I advise to perform everything
that follows with Ruby 1.9.3-p0, as things start breaking with newer versions
of Ruby. You can use rbenv to manage your Ruby version.

Pre-Requisites
--------------

Rails 2.3 is not available on most modern linux distributions, but Bundler can
be used to install it. If you've not already installed Bundler, do so now.

    $ gem install bundler

List out your dependencies in `Gemfile` and install them.

    $ vim Gemfile
    $ cat Gemfile
    source "https://rubygems.org"
    gem  'pg',     '~>  0.15.0'
    gem  'rails',  '=   2.3.18'
    $ bundle install

I have found that rails v2.3.18 will often crash if you try to use sqlite as a
backend. This guide assumes the use of postgresql instead, and the `pg` gem
above is the relevant adapter.

Finally, create a new Rails project.

    $ bundle exec rails myapp

After you've created your new project, move `Gemfile` and `Gemfile.lock` into
the application. If you issued `rbenv local 1.9.3-p0` earlier, move
`.ruby-version` too.

    $ mv -t myapp Gemfile Gemfile.lock .ruby-version
    $ cd myapp

Database Setup
--------------

Rails apps often crash if the database backend has not been initialized, and
you'll need it anyway. Install and configure postgresql as needed for your
distribution. `config/database.yml` spells out how Rails interfaces with the
Rails app. Right now, we need the `username` parameter.

    $ grep username poll/config/database.yml | uniq
      username: poll

Rails cannot access the database unless the user `poll` exists on your system.
When prompted to "Enter name of role to add:", enter "poll".

    $ sudo -i -u postgre # become the postgre user
    $ createuser --interactive

Finally, we can initialize the Rails database.

    $ bundle exec rake db:create

If this fails, you may need to remove the following (deprecated) line from
`Rakefile`:

    require 'rake/rdoctask'

To ensure that the database backend _really_ is functional, you can run other
rake tasks. We don't really care about the exact value of the result, so long
as the rake task runs without crashing.

    $ bundle exec rake -T # list out available rake tasks
    $ bundle exec rake db:charset
    UTF8

Test It
-------

At this point, you should be able to run the built-in web-server.

    $ script/server 
    => Booting WEBrick
    => Rails 2.3.15 application starting on http://0.0.0.0:3000
    => Call with -d to detach
    => Ctrl-C to shutdown server
    ^C
    Exiting

Learn It
--------

Go read some documentation. The [Ruby on Rails
Guides](http://guides.rubyonrails.org/v2.3.8/getting_started.html) are a good
place to start.
