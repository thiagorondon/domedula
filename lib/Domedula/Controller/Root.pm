package Domedula::Controller::Root;
use Moose;
use namespace::autoclean;
use Email::Valid;

BEGIN { extends 'Domedula::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config( namespace => '' );

=head1 NAME

Domedula::Controller::Root - Root Controller for Domedula

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub root : PathPart('') : Chained('base') : Args(0) {}

sub hemocentros : Chained('base') Args(0) {}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {
}

=head1 AUTHOR

Thiago Rondon

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
