use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'Term::Time',
    license           => 'perl',
    dist_author       => 'Ivan Wills <ivan.wills@gmail.com>',
    dist_version_from => 'lib/Term/Time.pm',
    requires          => {
        'perl'             => 5.008,
    },
    build_requires => {
        'Test::More'     => '0.88',
        'Test::Warnings' => '0.026',
    },
    add_to_cleanup     => [ 'Term-Time-*' ],
    create_license     => 1,
    meta_merge => {
        resources => {
            repository => 'git://github.com/ivanwills/Term-Time.git',
            bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Term::Time',
        },
    },
);

$builder->create_build_script();
