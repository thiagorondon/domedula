
package Domedula::Schema::Usuario;

use strict;
use warnings;

use base qw( DBIx::Class );

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('usuario');
__PACKAGE__->add_columns(
    id       => { data_type => 'integer', is_auto_increment => 1 },
    nome     => { data_type => 'varchar' },
    type     => { data_type => 'varchar' }, # TODO
    grupo_id => { data_type => 'integer' },
    extra    => { data_type => 'varchar', is_nullable       => 1, },
    ts       => { data_type => 'timestamp' },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint( [qw/nome/] );

__PACKAGE__->belongs_to(
    grupo => 'Domedula::Schema::Grupo' => { 'foreign.id' => 'self.grupo_id' } );

__PACKAGE__->has_many( doacoes => 'Domedula::Schema::Doacao' =>
      { 'foreign.usuario_id' => 'self.id' } );

=head1 AUTHOR

Thiago Rondon, C<< <thiago.rondon at gmail.com> >>

=cut

1;
