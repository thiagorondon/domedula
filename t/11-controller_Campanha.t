
use strict;
use warnings;
use Test::More;
use Catalyst::Test 'Domedula';
use HTTP::Request::Common;

use FindBin qw($Bin);
use lib "$Bin/lib";
use DBICTest;


my $schema = DBICTest->init_schema;

ok( my $controller = Domedula->controller('Campanha') );

{
    my ( $res, $ctx ) = ctx_request( GET '/campanhas' ); 
    ok ( my $campanhas = $ctx->stash->{campanhas} );
}

{
    my ( $res, $ctx ) = ctx_request( GET '/campanha/a/doar' ); 
    is ( $ctx->stash->{template}, 'campanha/invalida.tt' );
}

{
    my ( $res, $ctx ) = ctx_request( GET '/campanha/1/doar' );
    ok ( $res->is_success );
}

{
    my ( $res, $ctx ) = ctx_request( POST '/campanha/1/doar', { email => 'foobar' } );
    is ( $ctx->stash->{err}, 100 );
}

{
    my ( $res, $ctx ) = ctx_request( GET '/campanha/1/doar' );
    ok ( my $campanha = $ctx->stash->{campanha} );
    ok ( my $doacoes_andamento = $campanha->doacoes_andamento );

    ( $res, $ctx ) = ctx_request( POST '/campanha/1/doar', { email => 'foo@bar.com' } );
    is ( $ctx->stash->{err}, undef);
    is ( $ctx->stash->{template} , 'campanha/doar_ok.tt' );
    ok ( my $user = $ctx->stash->{user} );
    is ( $user->email, 'foo@bar.com' );
    ok ( my $doacao = $ctx->stash->{doacao} );
    ok ( $doacao->id );

    ( $res, $ctx ) = ctx_request( GET '/campanha/1/doar' );
    ok ( $campanha = $ctx->stash->{campanha} );
    is ( $doacoes_andamento + 1, $campanha->doacoes_andamento );
}

done_testing;

