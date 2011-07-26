package Domedula::Controller::Campanha;

use Moose;
use namespace::autoclean;

use Email::Valid;
use WWW::Shorten::TinyURL;
use URI::Encode qw(uri_encode);
use URI::Escape;

BEGIN { extends 'Domedula::Controller' }

sub campanhas : Chained('base') Args(0) {
    my ( $self, $c ) = @_;
    my $rs = $c->model('DB::Campanha');
    $c->stash->{campanhas} = $rs->search();
}

sub campanha : Chained('base') PathPart('campanha') CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $rs = $c->model('DB::Campanha');
    $c->stash->{campanha} = $rs->find($id);

    unless ( $c->stash->{campanha} ) {
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

sub compartilhar : Chained('campanha') Args(1) {
    my ( $self, $c, $network ) = @_;

    my $obj = $c->stash->{campanha};

    my $url;

    if ( $network eq 'facebook' ) {
        $url = 'http://www.facebook.com/share.php?u=' . $obj->url;
    }

    if ( $network eq 'orkut' ) {
        $url =
            'http://promote.orkut.com/preview?nt='
          . 'orkut.com' . '&du='
          . uri_escape( $obj->url ) . '&tt='
          . uri_escape( $obj->nome ) . '&tn='
          . uri_escape( $obj->image ) . '&cn='
          . uri_escape( $obj->nome ) . ' '
          . uri_escape( $obj->url );
    }

    if ( $network eq 'twitter' ) {
        $url = 'http://twitter.com/?status=';
        my $title   = $obj->nome;
        my $shorten = makeashorterlink( $obj->url );
        my $tag     = '#doejunto';

        my $status = join( ' ',
            substr( $title, 0, 134 - ( length($shorten) + length($tag) ) ),
            '...', $shorten, $tag );
        $url .= uri_escape_utf8($status);
    }

    $c->res->redirect($url) if $url;

}

__PACKAGE__->meta->make_immutable;

1;
