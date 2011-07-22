
package Domedula::Schema::Result::Grupo;

use strict;
use warnings;

use base qw( DBIx::Class );

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('grupo');
__PACKAGE__->add_columns(
    id   => { data_type => 'integer', is_auto_increment => 1 },
    nome => { data_type => 'varchar', is_nullable       => 1 },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint( [qw/nome/] );

__PACKAGE__->has_many( usuarios => 'Domedula::Schema::Result::Usuario' =>
      { 'foreign.grupo_id' => 'self.id' } );

=head1 AUTHOR

Thiago Rondon, C<< <thiago.rondon at gmail.com> >>

=cut

1;
