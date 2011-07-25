
package Domedula::Controller;

use Moose;
use namespace::autoclean;

BEGIN {
    extends 'Catalyst::Controller';
}

sub base : Chained('/') PathPart('') CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $rs_hemocentro = $c->model('DB::Hemocentro');
    $c->stash->{hemocentros} = $rs_hemocentro;
}

1;

