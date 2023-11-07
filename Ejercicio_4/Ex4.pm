#!/bin/perl

use strict;
use warnings;

use Bio::DB::GenPept;

print "Ejecutando ejercicio 4\n\n";
if ($#ARGV + 1 < 2) {
    print "Se requieren al menos dos parámetros\n";
    exit;
}

my $blastFile = do {
    local $/ = undef;
    open my $fh, "<", $ARGV[0]
        or die "No se pudo abrir el archivo BLAST $ARGV[0]: $!";
    <$fh>;
};

my $pattern = $ARGV[1];
my $patternRegex = qr/$pattern/;
my @matches = $blastFile =~ m/(>.*(?:\n.+)*${patternRegex}.*(?:\n.+)*)/g;

if ($#matches > 0){
    print $#matches + 1 . " coincidencias encontradas para " . $pattern . "\n\n";

    for my $i (0 .. $#matches) {
      my $n = $i + 1;
      print "Coincidencia $n:\n\n";
      print "$matches[$i]\n\n";
    }
} else {
    print "No se encontraron coincidencias\n";
}

sub get_seq_from_db {
    my $db_obj = Bio::DB::GenPept->new;
    my $seq = $db_obj->get_Seq_by_acc($_[0]);
}

print "Impresión de coincidencias finalizada\n";

if ($#ARGV >= 2 and $#matches > 0)
{
  print "Descargando secuencias...\n";
  my $seqio_obj = Bio::SeqIO->new(-file => ">$ARGV[2]", -format => 'fasta');
  foreach (@matches) {
    my $acc = ($_ =~ m/>([^ ]*) /g)[0];
    print ">$acc\n";
    my $seq = get_seq_from_db($acc);
    $seqio_obj->write_seq($seq);
  }
} else {
  print "No se proporcionó una ruta de archivo de salida";
}

print "Finalizando";