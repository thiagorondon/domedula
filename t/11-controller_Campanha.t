
use strict;
use warnings;
use Test::More;
use Catalyst::Test 'Domedula';
use HTTP::Request::Common;

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
    my ( $res, $ctx ) = ctx_request( POST '/campanha/1/doar', { email => 'foo@bar.com' } );
    is ( $ctx->stash->{err}, undef);
    is ( $ctx->stash->{template} , 'campanha/doar_ok.tt' );
    ok ( my $user = $ctx->stash->{user} );
    is ( $user->email, 'foo@bar.com' );
    ok ( my $doacao = $ctx->stash->{doacao} );
    ok ( $doacao->id );
}

done_testing;

