package Paranoia;
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.01";

use Paranoia::Router;

sub import {
    Paranoia::Router->export_to_level(1);
    {
        my $caller = caller(0);
        no strict 'refs';
        *{"$caller\::to_app"} = \&to_app;
    }
}

sub to_app {
    my ($class) = caller(0);
    sub {
        my $env = shift;
        if (my $route = $class->router->match($env)) {
            return $route->{code}->($env);
        } else {
            return [404, [], ['not found']];
        }
    };
}

1;
__END__

=encoding utf-8

=head1 NAME

Paranoia - It's new $module

=head1 SYNOPSIS

    use Paranoia;

=head1 DESCRIPTION

Paranoia is ...

=head1 LICENSE

Copyright (C) mackee.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

mackee E<lt>macopy123@gmail.comE<gt>

=cut

