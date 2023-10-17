FROM bioperl/bioperl

WORKDIR /usr/src/app

COPY . .

RUN cpan -fi Bio::Seq && cpan -fi Bio::DB::GenBank && cpan -fi Bio::SeqIO 
RUN cpan -fi Bio::Tools::Run::RemoteBlast
RUN cpan -fi Bio::Tools::Run::StandAloneBlastPlus
RUN cpan -fi Bio::DB::GenPept
RUN cpan -fi Bio::Factory::EMBOSS
RUN cpan -fi Data::Dumper

CMD ["tail", "-f", "/dev/null"]