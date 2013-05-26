use strict;
use warnings;
use utf8;

use lib '../lib/';

use Paranoia;

get '/' => {
    message => { isa => 'Str', default =>'ok' }
},
sub {
    my ($req, $args) = @_;
    [200, [], [$args->{message}]];
};

__PACKAGE__->to_app;
