package Domedula::Controller::Campanha;
use Moose;
use namespace::autoclean;
use Email::Valid;

BEGIN { extends 'Domedula::Controller' }

sub campanha : Chained('base') PathPart('campanha') CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $rs = $c->model('DB::Campanha');
    $c->stash->{campanha} = $rs->find($id);

    unless ($c->stash->{campanha}) {
        $c->stash->{template} = 'campanha/invalida.tt';
        $c->detach;
    }

}

sub doar : Chained('campanha') Args(0) {
    my ( $self, $c ) = @_;

    $c->detach() unless $c->req->method eq 'POST';
    my $rs_usuario = $c->model('DB::Usuario');
    my $rs_doacao  = $c->model('DB::Doacao');

    my $email = $c->req->param('email');

    if ( !Email::Valid->address($email) ) {
        $c->stash->{err} = 100;
        $c->detach;
    }

    $c->stash->{user} = $rs_usuario->find_or_create(
        { email => $c->req->param('email'), ts => \'CURRENT_TIMESTAMP' } );

    $c->stash->{doacao} = $rs_doacao->create(
        {
            usuario_id  => $c->stash->{user}->id,
            campanha_id => $c->stash->{campanha}->id,
            ts          => \'CURRENT_TIMESTAMP',
            status      => 0
        }
    );

    $c->stash->{template} = 'campanha/doar_ok.tt';

}

sub campanhas : Chained('base') Args(0) {
    my ( $self, $c ) = @_;
    my $rs = $c->model('DB::Campanha');
    $c->stash->{campanhas} = $rs->search();
}

__PACKAGE__->meta->make_immutable;

1;
