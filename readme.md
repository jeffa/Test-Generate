Test-Generate
=============
Just another unit test generator.

Synopsis
--------
```
# write to test file
mktests --lang=perl < test.json > test.pl

# feed back to interpreter for immediate test run
mktests --lang=perl < test.json | perl -T
```

Backend API
-----------
```perl
use Test::Generate;

$generator = Test::Generate->new;

$tests = $generator->generate( input => $json, lang => $lang );
```

use Math::Window2Viewport;
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
perldoc Math::Window2Viewport
```
You can also find documentation at [metaCPAN](https://metacpan.org/pod/Test::Generate).

License and Copyright
---------------------
See [source POD](/lib/Test/Generate.pm).
