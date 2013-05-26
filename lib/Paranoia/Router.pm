package Paranoia::Router;
use strict;
use warnings;
use utf8;
use 5.010;
use Router::Simple;
use Data::Validator;
use Carp qw/croak/;
use Plack::Request;
use Try::Tiny;

use parent 'Exporter';
our @EXPORT = qw/get router/;

sub router {
    my $class = shift;
    no strict 'refs';
    no warnings 'once';
    ${"${class}::ROUTER"} ||= Router::Simple->new;
}

sub get {
    my $pkg = caller(0);
    my $route = shift;
    my $code;
    if (ref $_[0] eq "HASH") {
        my $rule = shift;
        my $controller = shift;
        $code = sub {
            my $env = shift;
            my $req = Plack::Request->new($env);
            state $validator = Data::Validator->new(
                %$rule
            );
            my $args = $validator->validate(%{$req->parameters});
            $controller->($req, $args);
        };
    }
    else {
        $code = $_[0];
    }

    $pkg->router->connect($route, {code => $code}, {method => ['GET', 'HEAD']});
}

1;

