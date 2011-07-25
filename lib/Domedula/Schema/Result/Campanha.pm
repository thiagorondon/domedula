
package Domedula::Schema::Result::Campanha;

use strict;
use warnings;

use base qw( DBIx::Class );

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('campanha');
__PACKAGE__->add_columns(
    id        => { data_type => 'integer', is_auto_increment => 1 },
    tipo_id   => { data_type => 'integer', size              => 1 },
    nome      => { data_type => 'varchar', size              => 255 },
    descricao => { data_type => 'longtext' },
    meta      => { data_type => 'integer' },
    tt_ini    => { data_type => 'timestamp' },
    tt_fim    => { data_type => 'timestamp' }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint( [qw/nome/] );

__PACKAGE__->belongs_to(
    tipo => 'Domedula::Schema::Result::Tipo' => { 'foreign.id' => 'self.tipo_id' } );

__PACKAGE__->has_many( doacoes => 'Domedula::Schema::Result::Doacao' =>
      { 'foreign.campanha_id' => 'self.id' } );

sub doacoes_andamento {
    my $self = shift;
    return $self->doacoes->count || 0;
}


=head1 AUTHOR

Thiago Rondon, C<< <thiago.rondon at gmail.com> >>

=cut

1;
