#! /usr/bin/perl -w

use Env 1.00;

print "current path used by bash: $PATH\n";
print "directories searched for modules: @main::INC\n";
print "version of module Env: $Env::VERSION\n";
