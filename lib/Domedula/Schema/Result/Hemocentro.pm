
package Domedula::Schema::Result::Hemocentro;

use strict;
use warnings;

use base qw( DBIx::Class );

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('hemocentro');
__PACKAGE__->add_columns(
    id          => { data_type => 'integer', is_auto_increment => 1 },
    nome        => { data_type => 'varchar', is_nullable       => 1 },
    endereco    => { data_type => 'varchar', size              => 255 },
    site        => { data_type => 'varchar', size              => 255 },
    responsavel => { data_type => 'varchar', size              => 255 },
    email       => { data_type => 'varchar', size              => 255 },
    telefone    => { data_type => 'integer', size              => 10 },
    lat         => { data_type => 'varchar' },
    lon         => { data_type => 'varchar' }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint( [qw/nome/] );

=head1 AUTHOR

Thiago Rondon, C<< <thiago.rondon at gmail.com> >>

=cut

1;
