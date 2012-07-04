#! /usr/bin/perl

@db1 = (0..99);
@db2[99] = (99);
@db3[99] = (0..0);

@db3[2] = 1;
printf ("\$db1[0] == %d\n", @db1[0]);
printf ("\$db1[1] == %d\n", @db1[1]);
printf ("\$db1[99] == %d\n", @db1[99]);
printf ("\$db1[100] == %d\n", @db1[100]);
printf ("\n");
printf ("\$db2[0] == %d\n", @db2[0]);
printf ("\$db2[1] == $d\n", @db2[1]);
printf ("\$db2[99] == %d\n", @db2[99]);
printf ("\$db2[100] == %d\n", @db2[100]);
printf ("\n");
printf ("\$db3[0] == %d\n", @db3[0]);
printf ("\$db3[1] == %d\n", @db3[1]);
printf ("\$db3[2] == %d\n", @db3[2]);
printf ("\$db3[99] == %d\n", @db3[99]);
printf ("\$db3[100] == %d\n", @db3[100]);

<STDIN>;
