package Term::Time;

# Created on: 2016-07-14 15:28:14
# Create by:  Ivan Wills
# $Id$
# $Revision$, $HeadURL$, $Date$
# $Revision$, $Source$, $Date$

use strict;
use warnings;
use version;
use Carp;
use English qw/ -no_match_vars /;
use Path::Tiny;
use File::Temp qw/tempfile/;
use JSON::XS qw/decode_json/;

use base qw/Exporter/;

our $VERSION     = version->new('0.0.1');
our @EXPORT_OK   = qw/ttime/;
our %EXPORT_TAGS = ();
our @EXPORT      = qw/ttime/;

sub ttime {
    my @command = @_;
    my ($tempfh, $tempfile) = tempfile();
    my @time = q/time -f '{"real":"%e","user":"%U","sys":"%S","mem":{"unshared":"%D","avgtotal":"%K","resedent":"%M","shared":"%X"},"cpu":{"percent":"%P","kernel":"%S","user":"%U"}}' -o /. $tempfile;

    # close write fh
    close $tempfh;
    open my $time, '-|', join ' ', @time, @command;

    my $tmp = <$time>;

    wait;
    close $time;
    my $json_text = scalar path($tempfile)->slurp;
    my $json = decode_json($json_text);

    return $json;
}

1;

__END__

=head1 NAME

Term::Time - A library for getting the timings and other statistics for running code

=head1 VERSION

This documentation refers to Term::Time version 0.0.1

=head1 SYNOPSIS

   use Term::Time;

   # ttime is exported by default and called with at shell script to execute
   my $times = ttime('some --shell --program');
   # $times =
   #{
   #    cpu => {
   #        kernel => '0.44',
   #        percent => '99%',
   #        user => '0.07'
   #    },
   #    mem => {
   #        avgtotal => '0',
   #        resedent => '2460',
   #        shared => '0',
   #        unshared => '0'
   #    },
   #    real => '0.52',
   #    sys => '0.44',
   #    user => '0.07'
   #}

=head1 DESCRIPTION

Uses the C<time> command to execute a command and get the running
statistics for that program.

=head1 SUBROUTINES/METHODS

=head2 C<ttime ( $command )>

Executes C<$command> are returns the statistics (memory/CPU) for the run.

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

There are no known bugs in this module.

Please report problems to Ivan Wills (ivan.wills@gmail.com).

Patches are welcome.

=head1 AUTHOR

Ivan Wills - (ivan.wills@gmail.com)

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2016 Ivan Wills (14 Mullion Close, Hornsby Heights, NSW Australia 2077).
All rights reserved.

This module is free software; you can redistribute it and/or modify it under
the same terms as Perl itself. See L<perlartistic>.  This program is
distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

=cut
