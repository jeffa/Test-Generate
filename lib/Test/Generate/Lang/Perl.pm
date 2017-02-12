package Test::Generate::Lang::Perl;
use strict;
use warnings;
use base 'Test::Generate::Lang';
use Template;

sub _generate {
    my $data = shift;
    my $tmpl = Template->new;

    my $perl;
    $tmpl->process( _exec_template(), $data, \$perl ) or die $tmpl->error;
    my @results; eval $perl; warn $! if $@;
    $_->{result} = shift @results for @{ $data->{tests} };

    my $tests;
    $tmpl->process( _test_template(), $data, \$tests ) or die $tmpl->error;
    return $tests;
}


sub _blocks {
    my $text = q^
        [% BLOCK method %]
            $[% c.instance %]->[% t.method %]( [% PROCESS args args=t.args %] )
        [% END %]
        [% BLOCK args %]
            [% IF args.1.list.size %]
                [% FOREACH arg IN args %]
                    [% arg.0 %] => [% arg.1 %][% IF !loop.last %], [% END %]
                [% END %]
            [% ELSE %]
                [% args.join(", " ) %]
            [% END %]
        [% END %]
    ^;
    $text =~ s/\s{2,}//g;
    $text =~ s/\n//g;
    return $text;
}


sub _exec_template {
return \( q^
use [% class.name %];
[%- FOREACH line IN defined %][% line %][% END %]
my $[% class.instance %] = [% class.name %]->new( [% PROCESS args args=class.args %] );
[%- FOREACH test IN tests %]
[%- IF test.filter %]
push @results, [% test.filter %]( [% PROCESS method c=class t=test %] );
[%- ELSE %]
push @results, [% PROCESS method c=class t=test %];
[%- END %]
[%- END %]
^ . _blocks() );
}


sub _test_template {
return \( q^
#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More tests => [% tests.size + 1 %];
use [% class.name %];

[%- FOREACH line IN defined %]
[% line %];
[%- END %]

my $[% class.instance %] = new_ok '[% class.name %]', [ [% PROCESS args args=class.args %] ];

[%- FOREACH test IN tests %]
[%- IF test.filter %]
is [% test.filter %]( [% PROCESS method c=class t=test %] ), '[% test.result %]', '[% test.name %]';
[%- ELSE %]
is $[% class.instance %]->[% test.method %]( [% test.args.join(", " ) %] ), '[% test.result %]', '[% test.name %]';
[%- END %]
[%- END %]
^ . _blocks() );
}

1;


=head1 NAME

Test::Generate::Lang::Perl;

=head1 DESCRIPTION

This package defines the template for Perl unit tests.

=head1 AUTHOR

Jeff Anderson, C<< <jeffa at cpan.org> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2016 Jeff Anderson.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut
