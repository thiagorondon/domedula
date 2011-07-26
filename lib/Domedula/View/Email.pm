package Domedula::View::Email;

use strict;
use base 'Catalyst::View::Email';

__PACKAGE__->config(
    stash_key => 'email'
);

=head1 NAME

Domedula::View::Email - Email View for Domedula

=head1 DESCRIPTION

View for sending email from Domedula. 

=head1 AUTHOR

Thiago Rondon

=head1 SEE ALSO

L<Domedula>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
