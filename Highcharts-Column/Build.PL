use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Highcharts::Column',
    license             => 'perl',
    dist_author         => 'Hayashi Naoto <Hayashi.Naoto@gmail.com>',
    dist_version_from   => 'lib/Highcharts/Column.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'Highcharts-Column-*' ],
);

$builder->create_build_script();
