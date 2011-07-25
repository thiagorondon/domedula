
use strict;
use warnings;
use Test::More;
use Catalyst::Test 'Domedula';
use HTTP::Request::Common;

ok( my $controller = Domedula->controller('Root') );

{
    my ( $res, $ctx ) = ctx_request( GET '/hemocentros' ); 
    ok ( my $hemocentros = $ctx->stash->{hemocentros} );
}

done_testing;
