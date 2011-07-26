
use strict;
use warnings;
use Test::More;
use Catalyst::Test 'Domedula';
use HTTP::Request::Common;

use FindBin qw($Bin);
use lib "$Bin/lib";

#use DBICTest;

#my $schema = DBICTest->init_schema;

ok( my $controller = Domedula->controller('Campanha') );

{
    my ( $res, $ctx ) = ctx_request( GET '/campanhas' );
    ok( my $campanhas = $ctx->stash->{campanhas} );
}

{
    my ( $res, $ctx ) = ctx_request( GET '/campanha/a/doar' );
    is( $ctx->stash->{template}, 'campanha/invalida.tt' );
}

{
    my ( $res, $ctx ) = ctx_request( GET '/campanha/1/doar' );
    ok( $res->is_success );
}

{
    my ( $res, $ctx ) =
      ctx_request( POST '/campanha/1/doar', { email => 'foobar' } );
    is( $ctx->stash->{err}, 100 );
}

{
    my ( $res, $ctx ) = ctx_request( GET '/campanha/1/doar' );
    ok( my $campanha          = $ctx->stash->{campanha} );
    ok( my $doacoes_andamento = $campanha->doacoes_andamento );

    ( $res, $ctx ) =
      ctx_request( POST '/campanha/1/doar', { email => 'foo@bar.com' } );
    is( $ctx->stash->{err},      undef );
    is( $ctx->stash->{template}, 'campanha/doar_ok.tt' );
    ok( my $user = $ctx->stash->{user} );
    is( $user->email, 'foo@bar.com' );
    ok( my $doacao = $ctx->stash->{doacao} );
    ok( $doacao->id );

    ( $res, $ctx ) = ctx_request( GET '/campanha/1/doar' );
    ok( $campanha = $ctx->stash->{campanha} );
    is( $doacoes_andamento + 1, $campanha->doacoes_andamento );
}

{
    my ( $ret, $ctx ) = ctx_request( GET '/campanha/1/compartilhar/facebook' );
    is( $ret->header('location'),
'http://www.facebook.com/share.php?u=http://xxx.com/campanha/1/compartilhar'
    );
}

{
    my ( $ret, $ctx ) = ctx_request( GET '/campanha/1/compartilhar/twitter' );
    is( $ret->header('location'),
'http://twitter.com/?status=Campanha%20Nacional%20para%2010.000%20...%20http%3A%2F%2Ftinyurl.com%2F3lx3vr4%20%23doejunto'
    );
}

{
    my ( $ret, $ctx ) = ctx_request( GET '/campanha/1/compartilhar/orkut' );
    is( $ret->header('location'),
'http://promote.orkut.com/preview?nt=orkut.com&du=http%3A%2F%2Fxxx.com%2Fcampanha%2F1%2Fcompartilhar&tt=Campanha%20Nacional%20para%2010.000&tn=http%3A%2F%2Fxxx.com%2Fimage.png&cn=Campanha%20Nacional%20para%2010.000 http%3A%2F%2Fxxx.com%2Fcampanha%2F1%2Fcompartilhar'
    );

}

done_testing;

