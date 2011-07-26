
package DBICTest;

use strict;
use warnings;
use Domedula::Schema;

sub _sqlite_dbname {
    return "t/var/data.db";
    return ":memory:";
}

sub _database {
    my $self    = shift;
    my $db_file = $self->_sqlite_dbname;

    return ( "dbi:SQLite:${db_file}", '', '', { AutoCommit => 1 } );
}

sub init_schema {
    my $self = shift;
    my $schema =
      Domedula::Schema->compose_connection( 'Domedula', $self->_database );

    eval {
    $self->deploy_schema($schema);
    $self->populate_schema($schema);
    };

    return $schema;
}

sub deploy_schema {
    my $self   = shift;
    my $schema = shift;

    $schema->deploy;
}

sub populate_schema {
    my $self   = shift;
    my $schema = shift;

    $schema->populate( 'tipo', [ 1, 'Medula Ossea', 'Medula Ossea descricao' ],
    );

    $schema->populate(
        'campanha',
        [
            1, 1,
            'Campanha Nacional para 10.000',
            'Foobar descricao',
            10000,
            '2010-07-01 00:00:00',
            '2010-07-30 00:00:00'
        ]
    );

    $schema->populate(
        'hemocentro',
        [
            1,             'Hemocentro Teste',
            'Rua foobar',  'http://foobar.com',
            'Responsavel', 'foo@bar.com.br',
            113344112233,  '-23.547778',
            '-46.635833'
        ]
    );

}

1;
