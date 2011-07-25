package Domedula::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

Domedula::Controller::Root - Root Controller for Domedula

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub base :Chained('/') PathPart('') CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub root :PathPart('') :Chained('base')  :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    #$c->response->body( $c->welcome_message );
}

sub hemocentros : Chained('base') Args(0) {
    my ( $self, $c ) = @_;
    my $rs = $c->model('DB::Hemocentro');
    $c->stash->{hemocentros} = $rs;
}

sub campanha_invalida : Chained('base') PathPart('campanha/invalida') Args(0) { }

sub campanha : Chained('base') PathPart('campanha') CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $rs = $c->model('DB::Campanha');
    $c->stash->{campanha} = $rs->find($id) or $c->res->redirect('/campanha/invalida');
}

sub doar : Chained('campanha') Args(0) {
    my ( $self, $c ) = @_;

    $c->detach() unless $c->req->method eq 'POST';
    my $rs = $c->model('DB::Doacao');
}

sub campanhas :Chained('base') Args(0) {
    my ( $self, $c ) = @_;
    
    my $rs = $c->model('DB::Campanha');
    $c->stash->{campanhas} = $rs->search();
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Thiago Rondon

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
