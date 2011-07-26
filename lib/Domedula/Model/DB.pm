package Domedula::Model::DB;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model::DBIC::Schema';

my $dbfile = 'data.db';
$dbfile = 't/var/data.db' if -r 't/lib/DBICTest.pm';

warn $dbfile;

__PACKAGE__->config(
    schema_class => 'Domedula::Schema',

    connect_info => {
        dsn      => "dbi:SQLite:dbname=$dbfile",
        user     => '',
        password => '',
    }
);

=head1 NAME

Domedula::Model::DB - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

Thiago Rondon

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
