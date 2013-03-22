= CIS-3030 Sample Program 1

This program demonstrates how to create a simple binary search tree using Ruby.
The tree created is extremely simple: you can't do useful things like delete
tree nodes.

{Bundler}[http://gembundler.com/] is used to manage the gems upon which this
application depends. To install dependencies, first install Bundler with
<tt>gem install bundler</tt> (Bundler is itself a gem), then run <tt>bundle
install</tt>. At this point, the program can be run.

This program was originally written by Jeremy Audet and Henry Corse for Vermont
Technical College's CIS-3030 "Programming Languages" course, taught by Peter
Chapin.

== How-To

To run unit tests:

    ruby -I . TestTree.rb

To generate documentation:

    rdoc

== Files

[Tree.rb]

    Defines the module +Tree+ and two classes: +TreeNode+ and +Tree+.

[TestTree.rb]

    Includes unit tests for the +Tree+ module.
