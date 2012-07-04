#! /usr/bin/perl -w

# A simple subnet calculator for ipv4.
# Inputs are: ip address, mask
# inputs are in the form of command-line arguments
# Outputs are: network address, broadcast address, host addresses.
# @ARGV holds arguments, $#ARGV is subscript of last element of @ARGV

#-------------------------------------------------------------------------------
# Global Variable Declarations
#-------------------------------------------------------------------------------

# None so far.

#-------------------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------------------
my $ipAddress = $ARGV[0];	# IP Address, as gotten from the user
my @ipAddressDecimal = ();	# IP Address, split into four separate decimal numbers
my @ipAddressBinary = ();	# IP Address, as an array of ones and zeroes

my $netmask = $ARGV[1];		# netmask, as gotten from the user
my @netmaskDecimal = ();	# netmask, split into four separate decimal numbers
my @netmaskBinary = ();		# netmask, as an array of ones and zeroes

my @networkAddressBinary = ();	# network address, as an array of ones and zeroes
my @networkAddressDecimal = ();	# network address, split into four separate decimal numbers

my @broadcastAddressDecimal = ();	# broadcast address, split into four decimal numbers.

my $blockSize = 0;
my $splitOctet = 0;		# which of the four numbers in @networkAddressDecimal has both network and host bits? i.e. which of the four numbers is the block size applied to?
my $i = 0;

if ($#ARGV != 1) {
	print "Form:    subnetcalc <ip_address> <netmask>\n";
	print "Example: ./subnetcalc.pl 155.195.86.181 255.255.255.192\n";
	print "ip_address can only be an ipv4 address, in the form w.x.y.z\n";
	print "netmask can only be an ipv4 netmask, in form w.x.y.z\n";
	exit;
}

# netmask validation, translation
#---------------------------------------
if ($netmask !~ /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/) {
	print "\nERROR: netmask must consist of four sets of numbers.\n";
	exit;
} else {
	$netmaskDecimal[0] = $1;
	$netmaskDecimal[1] = $2;
	$netmaskDecimal[2] = $3;
	$netmaskDecimal[3] = $4;
}
foreach $i (@netmaskDecimal) {
	if ($i > 255) {
		print "\nERROR: netmask cannot include numbers greater than 255\n";
		exit;
	}
}
@netmaskBinary = &decimal_to_binary($netmaskDecimal[0]);
@netmaskBinary = (@netmaskBinary, &decimal_to_binary($netmaskDecimal[1]));
@netmaskBinary = (@netmaskBinary, &decimal_to_binary($netmaskDecimal[2]));
@netmaskBinary = (@netmaskBinary, &decimal_to_binary($netmaskDecimal[3]));
for ($i = 0; $i < scalar(@netmaskBinary) - 1; $i++) {
	if ($netmaskBinary[$i] < $netmaskBinary[$i + 1]) {
		print "\nERROR: When translated into binary, the netmask must be a string of ones by\n";
		print "followed a string of zeroes. The sequence '01' cannot be found in the binary\n";
		print "netmask.\n";
		exit;
	}
}
#---------------------------------------
# END netmask validation, translation

# IP address validation, translation
#---------------------------------------
if ($ipAddress !~ /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/) {
	print "\nERROR: IP address must consist of four sets of numbers.\n";
	exit;
} else {
	$ipAddressDecimal[0] = $1;
	$ipAddressDecimal[1] = $2;
	$ipAddressDecimal[2] = $3;
	$ipAddressDecimal[3] = $4;
}
foreach $i (@ipAddressDecimal) {
	if ($i > 255) {
		print "\nERROR: the IP address cannot include numbers greater than 255\n";
		exit;
	}
}
@ipAddressBinary = &decimal_to_binary($ipAddressDecimal[0]);	# decimal IP address is converted into eight binary
@ipAddressBinary = (@ipAddressBinary, &decimal_to_binary($ipAddressDecimal[1]));# digits. In total, the binary
@ipAddressBinary = (@ipAddressBinary, &decimal_to_binary($ipAddressDecimal[2]));# IP address will consist of 32
@ipAddressBinary = (@ipAddressBinary, &decimal_to_binary($ipAddressDecimal[3]));# elements
#---------------------------------------
# END IP address validation, translation

for ($i = 0; $i < scalar(@ipAddressBinary); $i++) {	# Apply the netmask to the IP address.
							# The result is the network address, in binary.
	if ($netmaskBinary[$i] == 1) {
		$networkAddressBinary[$i] = $ipAddressBinary[$i];
	} else {
		$networkAddressBinary[$i] = 0;
	}
}
$networkAddressDecimal[0] = &binary_to_decimal(@networkAddressBinary[0..7]);
$networkAddressDecimal[1] = &binary_to_decimal(@networkAddressBinary[8..15]);
$networkAddressDecimal[2] = &binary_to_decimal(@networkAddressBinary[16..23]);
$networkAddressDecimal[3] = &binary_to_decimal(@networkAddressBinary[24..31]);

# START	find block size
#---------------------------------------
$i = 0;					# Example: Ten bits are used in the netmask. The first eight bits are applied to the first
while ($netmaskBinary[$i] == 1) {	# address. This means that two bits are used as network bits in the second octet, and six
	$i++;				# bits are used as host bits. 2^6 bits are used as host bits; therefore, the block size is
}					# 64.
$splitOctet = int($i / 8);
$i = $i % 8;				# If netmaskBinary[10] is a zero, then the tenth netmask bit is a one. 10 modulo 8 is 2.
$i = 8 - $i;				# This tells you that TWO bits are network bits. 8 - 2 = 6. Six bits are host bits.
$blockSize = 2**$i;			# Block size is 2^6, or 64.
#---------------------------------------
# END find block size

for ($i = 0; $i < $splitOctet; $i++) {
	$broadcastAddressDecimal[$i] = $networkAddressDecimal[$i];
}
$broadcastAddressDecimal[$splitOctet] = $networkAddressDecimal[$splitOctet] + $blockSize - 1;
for ($i = $splitOctet + 1; $i < 4; $i++) {
	$broadcastAddressDecimal[$i] = 255;
}

print "IP Address given:  $ipAddress\n";
print "Netmask given:     $netmask\n";
print "---------------------\n";
print "Network Address:   $networkAddressDecimal[0].$networkAddressDecimal[1].$networkAddressDecimal[2].$networkAddressDecimal[3]\n";
print "Broadcast Address: $broadcastAddressDecimal[0].$broadcastAddressDecimal[1].$broadcastAddressDecimal[2].$broadcastAddressDecimal[3]\n";
print "Block Size:        $blockSize\n";
if (($splitOctet == 3 && $blockSize <= 2) || $splitOctet == 4) {
	print "Host bits:         none.\n";
} else {
	$i = $networkAddressDecimal[$splitOctet] + 1;
	print "Host bits:         $networkAddressDecimal[0].$networkAddressDecimal[1].$networkAddressDecimal[2].$i through ";
	$i = $broadcastAddressDecimal[$splitOctet] - 1;
	print "$broadcastAddressDecimal[0].$broadcastAddressDecimal[1].$broadcastAddressDecimal[2].$i\n";
}

#-------------------------------------------------------------------------------
# SUBS!
#-------------------------------------------------------------------------------
# SUB: decimal_to_binary()
#-------------------------------------------------------------------------------
sub decimal_to_binary {
	my $decimal = $_[0];
	my @binary = ();
	my $i = 0;
	my $divisor = 128;

	for ($i = 0, $divisor = 128; $i < 8; $i++, $divisor = $divisor / 2) {
		if ($decimal / $divisor >= 1) {		# If the decimal number passed is divisible by 128, then
			$binary[$i] = 1;		# the 8th binary bit is a one and use modulus to find 
			$decimal = $decimal % $divisor;	# the remainder. Otherwise, the 8th binary bit is a zero.
		} else {				# If the decimal number is divisible by 64, then the 7th 
			$binary[$i] = 0;		# binary bit is a one...
		}
	}

	return @binary;
}

#-------------------------------------------------------------------------------
# SUB: binary_to_decimal()
#-------------------------------------------------------------------------------
sub binary_to_decimal {
	my @binary = @_;
	my $decimal = 0;
	my $binaryDigit = 0;
	my $i = 128;

	foreach $binaryDigit (@binary) {	# The first binary digit is the MSB. If the first digit is a one, 
		if ($binaryDigit == 1) {	# then add 128 to the decimal number. If the second binary digit
			$decimal = $decimal + $i;	# is a one, then add 64 to the decimal number. If the
		}				# third binary digit is a one...
		$i = $i / 2;
	}

	return $decimal;
}
