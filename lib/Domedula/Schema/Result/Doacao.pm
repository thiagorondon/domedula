
package Domedula::Schema::Result::Doacao;

use strict;
use warnings;

use base qw( DBIx::Class );

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('doacao');
__PACKAGE__->add_columns(
    id          => { data_type => 'integer', is_auto_increment => 1 },
    usuario_id  => { data_type => 'integer' },
    campanha_id => { data_type => 'integer' },
    ts          => { data_type => 'timestamp' },

);

__PACKAGE__->belongs_to( usuario => 'Domedula::Schema::Result::Usuario' =>
      { 'foreign.id' => 'self.usuario_id' } );

__PACKAGE__->belongs_to( campanha => 'Domedula::Schema::Result::Campanha' =>
      { 'foreign.id' => 'self.campanha_id' } );

=head1 AUTHOR

Thiago Rondon, C<< <thiago.rondon at gmail.com> >>

=cut

1;
