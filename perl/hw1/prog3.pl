#! /usr/bin/perl
# This program experiments with tabs a little bit.

print "int main(void)\n";
print "{\n";
print "\tprintf(\"Hello, world!\\n\");\n";	# Escape characters are tested heavily here.
print "\n";
print "test\treturn 0;\n";			# Note that "test" does not push "return 0;" ahead four spaces.
print "}\n";
