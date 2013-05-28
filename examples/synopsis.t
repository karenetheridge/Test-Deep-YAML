use strict;
use warnings FATAL => 'all';

use Test::More;
use Test::Deep;
use Test::Deep::YAML;

cmp_deeply(
    "---\nfoo: bar\n",
    yaml({ foo => 'bar' }),
    'YAML-encoded data is correct',
);

done_testing;
