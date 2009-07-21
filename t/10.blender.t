#!perl -T

use strict;
use warnings;
use utf8;

use Test::More tests => 7;

use String::Blender;

can_ok("String::Blender", 'new');

my $blender = String::Blender->new(
    vocabs => [
        ['doi:#1/pn', 'aAsZ.1$.\^'],
        ['я�¿', 'ミュニティーの一員'],
    ],
    min_length       => 10,
    max_length       => 30,
    min_elements     => 3,
    max_elements     => 5,
    max_tries_factor => 4,
);

isa_ok($blender, 'String::Blender');
can_ok($blender, 'blend');
can_ok($blender, 'load_vocabs');

my $vocabs = [
    [qw/web net host site list archive core base switch/],
    [qw/candy honey muffin sugar sweet yammy/],
    [qw/area city club dominion empire field land valley world/],
];

ok($blender->vocabs($vocabs), "setting vocabs");

$blender->quantity(2500);

ok(2500 == $blender->quantity, "setting quantity");
diag "Blender quantity = " . $blender->quantity;

my $r_quantity = scalar($blender->blend);

ok(2500 == $r_quantity, "sufficient blend() result");
diag "Resulting quantity = $r_quantity";
