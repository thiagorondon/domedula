package Domedula::View::TT;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
    INCLUDE_PATH =>
              [ map { Domedula->path_to(@$_) }[qw(root src)], [qw(root lib)] ],
    WRAPPER => 'wrapper.tt'
);

=head1 NAME

Domedula::View::TT - TT View for Domedula

=head1 DESCRIPTION

TT View for Domedula.

=head1 SEE ALSO

L<Domedula>

=head1 AUTHOR

Thiago Rondon

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
