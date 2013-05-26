use strict;
use warnings;
use utf8;

use lib '../lib/';

use Paranoia;

get '/' => sub {
    [200, [], 'ok']
};

__PACKAGE__->to_app;

1;

