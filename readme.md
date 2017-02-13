Test-Generate
=============
Just another unit test generator. [![Build Status](https://api.travis-ci.org/jeffa/Test-Generate.svg?branch=master)](https://travis-ci.org/jeffa/Test-Generate)

Synopsis
--------
```
# write to test file
mktests perl < test.json > test.pl

mktests ruby < test.json > test.rb

# feed back to interpreter for immediate test run
mktests perl < test.json | perl -T
```

Backend API
-----------
```perl
use Test::Generate;

$generator = Test::Generate->new;

$tests = $generator->generate( input => $json, lang => $lang );
```
See [/t/data/](/t/data/) for example JSON source files.

Installation
------------
To install this module, you should use CPAN. A good starting
place is [How to install CPAN modules](http://www.cpan.org/modules/INSTALL.html).

If you truly want to install from this github repo, then
be sure and create the manifest before you test and install:
```
perl Makefile.PL
make
make manifest
make test
make install
```

Support and Documentation
-------------------------
After installing, you can find documentation for this module with the
perldoc command.
```
perldoc Test::Generate
```
You can also find documentation at [metaCPAN](https://metacpan.org/pod/Test::Generate).

License and Copyright
---------------------
See [source POD](/lib/Test/Generate.pm).
