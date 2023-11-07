#!/bin/perl

use strict;
use warnings;

use Bio::SeqIO;
use Bio::Factory::EMBOSS;
use Data::Dumper;

print "Ejecutando ejercicio 5\n\n";

if ($#ARGV + 1 < 3) {
    print "Se requieren tres parámetros\n";
    exit;
}

my $factory = new Bio::Factory::EMBOSS;
print "Ejecutando programa transeq\n";
$factory->program('transeq')->run({-sequence => $ARGV[0], -outseq => $ARGV[1], -frame => 6});
print "Ejecutando programa prosextract\n";
$factory->program('prosextract')->run({});
print "Ejecutando programa patmatmotifs\n";
$factory->program('patmatmotifs')->run({-sequence => $ARGV[1], -outfile => $ARGV[2], -full => 'Y'});

print "Finalizando";