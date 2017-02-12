package Test::Generate::Lang::Ruby;
use strict;
use warnings;
use base 'Test::Generate::Lang';
use Template;

sub _generate {
    my $data = shift;
    ($data->{require}  = $data->{class}{name}) =~ s/::/\//g;
    ($data->{testname} = $data->{class}{name}) =~ s/:://g;

    my $tmpl = Template->new;
    my $tests;
    $tmpl->process( _test_template(), $data, \$tests ) or die $tmpl->error;
    return $tests;
}


sub _test_template {
return \<<END_TEMPLATE;
require "[% require %]"
[% class.instance %] = [% class.name %].new( [% FOREACH arg IN class.args %][% arg.0 %] => [% arg.1 %], [% END %] )
puts %q^require "test/unit"^
puts %q^require "[% require %]"^
puts %q^^
puts %q^class Test[% testname %] < Test::Unit::TestCase^
puts %q^^
puts %q^    def test^
puts %q^^
puts %q^        [% class.instance %] = [% class.name %].new( [% FOREACH arg IN class.args %][% arg.0 %] => [% arg.1 %], [% END %] )^
puts %q^^
[%- FOREACH test IN tests %]
puts %q^        assert_equal( '^ + [% PROCESS method c=class t=test %] + %q^', [% PROCESS method c=class t=test %], '[% test.name %]' )^
[%- END %]
puts %q^    end^
puts %q^end^
[%- BLOCK method %][% c.instance %].[% t.method %]( [% t.args.join(", " ) %] )[% END %]
END_TEMPLATE
}

1;


=head1 NAME

Test::Generate::Lang::Ruby;

=head1 DESCRIPTION

This package defines the template for Ruby unit tests.

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
