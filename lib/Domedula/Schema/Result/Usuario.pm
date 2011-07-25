
package Domedula::Schema::Result::Usuario;

use strict;
use warnings;

use base qw( DBIx::Class );

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('usuario');
__PACKAGE__->add_columns(
    id    => { data_type => 'integer',   is_auto_increment => 1 },
    email => { data_type => 'varchar' },
    ts    => { data_type => 'timestamp', default           => \'NOW()' },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint( [qw/email/] );

__PACKAGE__->has_many( doacoes => 'Domedula::Schema::Result::Doacao' =>
      { 'foreign.usuario_id' => 'self.id' } );

=head1 AUTHOR

Thiago Rondon, C<< <thiago.rondon at gmail.com> >>

=cut

1;
