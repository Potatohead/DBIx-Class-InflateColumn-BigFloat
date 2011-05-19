use inc::Module::Install;

name     'DBIx-Class-InflateColumn-BigFloat';
all_from 'lib/DBIx/Class/InflateColumn/BigFloat.pm';
author   q{Christopher Mckay <potatohead@potatolan.com>};
license  'perl';

build_requires 'Test::More';

requires 'DBIx::Class';
requires 'Math::BigFloat';
requires 'namespace::clean';

auto_install;

WriteAll;

