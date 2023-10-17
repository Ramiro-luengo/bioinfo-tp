FROM bioperl/bioperl

WORKDIR /usr/src/app

COPY . .

RUN cpan -fi Bio::Seq && cpan -fi Bio::DB::GenBank && cpan -fi Bio::SeqIO

CMD ["tail", "-f", "/dev/null"]