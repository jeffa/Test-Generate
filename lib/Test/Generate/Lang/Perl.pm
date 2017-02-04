package Test::Generate::Lang::Perl;
use strict;
use warnings;
use base 'Test::Generate::Lang';
use Text::Template;

sub _generate {
    my $data = shift;
    my $tmpl = Text::Template->new( TYPE => 'FILEHANDLE', SOURCE => *DATA );
    return $tmpl->fill_in( HASH => $data );
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

__DATA__
#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More tests => {$tests};

{ for (@include) { $OUT .= "use $_;\n" } }

my $mapper = new_ok 'Math::Window2Viewport', [
    Wb => 0, Wt => 1, Wl => 0, Wr => 1,
    Vb => 9, Vt => 0, Vl => 0, Vr => 9,
];

is int( $mapper->Dx( .5 ) ), '4',   "correct Dx()";
is int( $mapper->Dy( .6 ) ), '3',   "correct Dx()";

my ($x, $y);

$x = 0;
$y = sin( $x );
is int( $mapper->Dx( $x ) ), 0,   "correct Dx() sin wave 1/5";
is int( $mapper->Dy( $y ) ), 9,   "correct Dy() sin wave 1/5";

$x = 0.1;
$y = sin( $x );
is int( $mapper->Dx( $x ) ), 0,   "correct Dx() sin wave 2/5";
is int( $mapper->Dy( $y ) ), 8,   "correct Dy() sin wave 2/5";

$x = 0.2;
$y = sin( $x );
is int( $mapper->Dx( $x ) ), 1,   "correct Dx() sin wave 3/5";
is int( $mapper->Dy( $y ) ), 7,   "correct Dy() sin wave 3/5";

$x = 0.3;
$y = sin( $x );
is int( $mapper->Dx( $x ) ), 2,   "correct Dx() sin wave 4/5";
is int( $mapper->Dy( $y ) ), 6,   "correct Dy() sin wave 4/5";

$x = 0.4;
$y = sin( $x );
is int( $mapper->Dx( $x ) ), 3,   "correct Dx() sin wave 5/5";
is int( $mapper->Dy( $y ) ), 5,   "correct Dy() sin wave 5/5";
