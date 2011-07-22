
package Domedula::Schema::Result::Regiao;

use strict;
use warnings;

use base qw( DBIx::Class );

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('regiao');
__PACKAGE__->add_columns(
    id   => { data_type => 'integer', is_auto_increment => 1 },
    nome => { data_type => 'varchar', is_nullable       => 1 },
    geom => { data_type => 'geometry' }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint( [qw/nome/] );

=head1 AUTHOR

Thiago Rondon, C<< <thiago.rondon at gmail.com> >>

=cut

1;
