Ruby Environment Configuration
==============================

rbenv, ruby-build, and Bundler together allow you to control which ruby
version, gems, and gem versions an application uses. This document outlines how
to install, configure, and use these tools.

rbenv and ruby-build
====================

rbenv is a tool for managing which version of Ruby is used. It can do so on a
global, per-application, or per-shell level. Though rbenv allows you to use a
particular Ruby version, it does not include any built-in method of installing
Ruby executables. ruby-build is a plugin that provides this capability.

Install and Config
------------------

If rbenv and ruby-build are available through your package manager, go ahead
and install them. If they aren't, head over to [their
website][rbenv] for instructions. In brief:

    git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone git://github.com/sstephenson/ruby-build.git \
        ~/.rbenv/plugins/ruby-build

After installation, edit your `~/.bashrc`.

    if [[ -d "$HOME/.rbenv ]]; then
        export PATH="$HOME/.rbenv/bin:$PATH"
        eval "$(rbenv init -)"
    fi

Then, reload your `~/.bashrc`.

    $ source ~/.bashrc

Usage
-----

Remember to run `rbenv rehash` "after you install a new version of Ruby, or
install a gem that provides commands."

    $ rbenv install --list
    Available versions:
      1.8.6-p383
      1.8.6-p420
      1.8.7-p249
      ...
    $ rbenv install 2.0.0-p0
    $ rbenv install 1.9.3-p392
    $ rbenv install 1.8.7-p371
    $ rbenv rehash
    $ rbenv versions
    * system (set by /home/username/.rbenv/version)
      1.8.7-p371
      1.9.3-p392
      2.0.0-p0

There are three mechanisms which can set the current Ruby version. From lowest
priority to highest:

1. The `~/.rbenv/version` file.

    $ rbenv global 2.0.0-p0

2. A `.ruby-version` file in the current directory.

    $ rbenv local echo 2.0.0-p0
    $ rbenv local --unset

3. The `RBENV\_VERSION` environment variable.

    $ rbenv shell 2.0.0-p0
    $ rbenv shell --unset

To see which version of Ruby is currently being used, call `ruby --version`.
*Do not* call `which ruby`, as this will always return `~/.rbenv/shims/ruby`.
The same is true for all other executables built in to Ruby; call `gem
--version` instead of `which gem`.

Explanation: ~/.bashrc modification
-----------------------------------

The `if [[ -d "$HOME/.rbenv ]];` prevents the `export` and `eval` commands from
running unless an `~/.rbenv` folder exists. Though not strictly necessary, it
makes your `~/.bashrc` more portable: if you haven't installed rbenv on a
machine, the following `export` and `eval` statements won't run.

`export PATH` makes the `rbenv` command-line utility available for use. To
check and see if the `export` worked correctly, use `which`.

    $ which rbenv
    /home/username/.rbenv/bin/rbenv

The `eval` command does a couple fairly sane things, like adding
`~/.rbenv/shims` to your `PATH` and providing autocompletion. To see exactly
what happens, run `rbenv init -`, or see the [official docs][rbenv].

Explanation: how rbenv works
----------------------------

When you execute `ruby`, `~/.rbenv/shims/ruby` is run. This script is a
middleman between you and the actual ruby executables. It  it tries to figure
out which executable should be called by looking at environment variables
($RBENV\_VERSION) and files (`./ruby-version` and `~/.rbenv/version`). After
determining which version should be run, rbenv passes your request on to an
actual ruby executable, located somewhere in `~/.rbenv/versions`.

There are "shims" installed for all executables built in to Ruby. As a result,
calls to other utilities such as `gem` and `irb` are also intercepted.

    $ tree ~/.rbenv/shims/
    /home/username/.rbenv/shims/
    |-- erb
    |-- gem
    |-- irb
    |-- rake
    |-- rdoc
    |-- ri
    |-- ruby
    `-- testrb

Bundler
=======

Bundler is a tool for managing which gems and gem versions an application uses.
When used correctly, all requests for gems are routed through Bundler, which
can then supply the correct gem version to your application. See a full
explanation [here](http://gembundler.com/v1.3/rationale.html).

Install and Config
------------------

If Bundler is available through your package manager, go ahead and install it
with that. Otherwise, Bundler can be installed with `gem`.

    $ gem install bundler

That's it! Bundler is ready to use.

Usage
-----

A developer working on a project should create a file called `Gemfile` listing
out which gems it requires. For example:

    source 'http://rubygems.org'
    gem 'test-unit', '>=2.5.4'

`bundle install` installs the listed gems. Running `bundle install` also causes
Bundler to create a file called `Gemfile.lock`, which is a record of the full
tree of gems and gem versions installed. Bundler searches for `Gemfile` in the
current directory. If you change the version requirements of a gem (e.g. from
'=2.5.3' to '=2.5.4'), you can update that gem to the newest permissible
version with `bundle update`. (re-running `bundle install` again doesn't do
this) 

At this point, the necessary gems have been installed, but your application
still won't use them. Your application needs to be made bundler-aware, or else
requests for gems will not be routed through Bundler. To do this, put the
following at the top of the first executable of your application:

    require 'rubygems'
    require 'bundler/setup'

Finally, whenever you run your application, prefix the all with `bundle exec`.
Putting it all together into an example:

    $ ls
    Gemfile  Gemfile.lock  README.txt  TestTree.rb  Tree.rb
    $ grep require TestTree.rb
    require 'rubygems'
    require 'bundler/setup'
    require 'test/unit'
    require 'Tree'
    $ bundle exec ruby TestTree.rb

Troubleshooting
---------------

By default, Bundler will attempt to install gems in a system-wide directory. On
Arch Linux, at least, this is incorrect. To fix this behaviour, edit your
`~/.bashrc`.

    # This forces bundler to install gems on a per-user basis, instead of
    # system-wide. This matches the default `gem` behaviour on Arch Linux, and it
    # also allows gems to be installed without `sudo`.
    export GEM_HOME=~/.gem/versions/2.0.0/

Curiously, this means that the gems for _all_ ruby versions will be installed
in the `2.0.0` folder. This is kludgy, but it appears to work.

External Links
==============

[rbenv][]  
[ruby-build][]  
[Bundler][]  

[rbenv]: http://rbenv.org/
[ruby-build]: https://github.com/sstephenson/ruby-build  
[Bundler]: http://gembundler.com/  
