package SelfControl::Config;
my $ID = {
        date => q$Date$,
        headurl => q$HeadURL$,
        author => q$Author$,
        revision => q$Revision$,
};

use warnings;
use strict;

use Exporter qw<import>;
our @EXPORT = qw<load_config save_config>;

=head1 NAME

SelfControl::Config - The great new SelfControl::Config!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use SelfControl::Config;

    my $foo = SelfControl::Config->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

#
# Manipulate the ConfigFile.
#

sub load_config {
  my ($ConfigFile, $Config) = @_;
  if ( -f $ConfigFile ) {
    $Config = YAML::LoadFile($ConfigFile);
    if (exists $Config->{version}) {
      if ($Config->{version} < 2) {
        $Config->{can_queue} = 0;
        $Config->{version} = 2;
      }
      else {
        # can't happen. :)
      }
    }
    else {
      $Config->{timeout} *= 60;  # pre 'version' in hours, convert to minutes.
      $Config->{version} = 1;
    }
  }
  else {
    $Config = {
      allow => 1,
      can_queue => 0,
      hosts => [[qw<example.com 192.0.32.10>]],
      jobs => {},
      timeout => 5,
      version => 2,
    };
  }
  return $Config;
}
sub save_config {
  my ($ConfigFile, $Config) = @_;
  YAML::DumpFile($ConfigFile, $Config);
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

zengargoyle, C<< <zengargoyle at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-selfcontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=SelfControl>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SelfControl::Config


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=SelfControl>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/SelfControl>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/SelfControl>

=item * Search CPAN

L<http://search.cpan.org/dist/SelfControl/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 zengargoyle.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of SelfControl::Config
