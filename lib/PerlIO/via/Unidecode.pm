
require 5.008;
package PerlIO::via::Unidecode;
$VERSION = "1.01";
use strict;
use utf8 ('decode');
use Text::Unidecode ('unidecode');
# A little sanity-checking can't hurt:
die "Can't find &Text::Unidecode::unidecode" unless defined &unidecode;
die "Can't find &utf8::decode" unless defined &utf8::decode;

# Coded based on the example of PerlIO::via::QuotedPrint.

sub PUSHED { bless \*PUSHED,$_[0] }

sub FILL {
    my $line = readline( $_[1] );
    (defined $line) ? unidecode( $line ) : undef;
}

sub WRITE {
    my $x = $_[1];
    utf8::decode($x); # need to promote things back to UTF8
    unidecode($x);
    # utf8::downgrade($x);
    ( print {$_[2]} $x ) ? length($_[1]) : -1;
}

1;
__END__

=head1 NAME

PerlIO::via::Unidecode - a perlio layer for Unidecode

=head1 SYNOPSIS

  % cat utf8translit
  #!/usr/bin/perl
  use strict;
  use PerlIO::via::Unidecode;
  foreach my $f (@ARGV) {
    open IN, '<:encoding(utf8):via(Unidecode)', $f or die "$f -> $!\n";
    print while <IN>;
    close(IN);
  }
  __END__

  % od -x home_city.txt
  000000:  E5 8C 97 E4 BA B0 0D 0A

I<that's the the Chinese characters for Beijing, in UTF8>

  % utf8translit home_city.txt
  Bei Jing

=head1 DESCRIPTION

PerlIO::via::Unidecode implements a L<PerlIO::via> layer that applies Unidecode
(L<Text::Unidecode>) to data passed through it.

You can use PerlIO::via::Unidecode on already-Unicode data, as in the
example in the SYNOPSIS; or you can combine it with other layers, as in
this little program that converts KOI8R text into Unicode and then
feeds it to Unidecode, which then outputs an ASCII transliteration:

  % cat transkoi8r
  #!/usr/bin/perl
  use strict;
  use PerlIO::via::Unidecode;
  foreach my $f (@ARGV) {
    open IN, '<:encoding(koi8-r):via(Unidecode)', $f or die $!;
    print while <IN>;
    close(IN);
  }
  __END__

  % cat fet_koi8r.txt
  
  Когда читала ты мучительные строки,
  Где сердца звучный пыл сиянье льет кругом
  И страсти роковой вздымаются потоки,-
        Не вспомнила ль о чем?

  % transkoi8r fet_koi8r.txt

  Koghda chitala ty muchitiel'nyie stroki,
  Gdie sierdtsa zvuchnyi pyl siian'ie l'iet krughom
  I strasti rokovoi vzdymaiutsia potoki,-
      Nie vspomnila l' o chiem?

Of course, you could do this all by manually calling Text::Unidecode's
C<unidecode(...)> function on every line you fetch, but that's just what
C<:via(...)> layers do automatically do for you.

Note that you can also use C<:via(Unidecode)> as an output layer too.
In that case, add a dummy ":utf8" after it, as below, just to silence
some "wide character in print" warnings that you might otherwise
see.

  % cat writebei.pl
  use PerlIO::via::Unidecode;
  open OUT, ">:via(Unidecode):utf8", "rombei.txt" or die $!;
  print OUT "\x{5317}\x{4EB0}\n";
    # those are the Chinese characters for Beijing
  close(OUT);

  % perl writebei.pl
  
  % cat rombei.txt
  Bei Jing 

=head1 FUNCTIONS AND METHODS

This module provides no public functions or methods --
everything is done thru the C<via> interface.  If you want a function,
see L<Text::Unidecode>.

=head1 TIPS

Don't forget the "use PerlIO::via::Unidecode;" line, and be sure to
get the case right.

Don't type "Unicode" when you mean "Unidecode", nor vice versa.

Handy modes to remember:

  <:encoding(utf8):via(Unidecode)
  <:encoding(some-other-encoding):via(Unidecode)
  >:via(Unidecode):utf8

=head1 SEE ALSO

L<Text::Unidecode>

L<PerlIO::via>

L<Encode> and L<Encode::Supported> (even though the modes they
implement are called as "C<:encodI<ing>(...)>").

L<PerlIO::via::PinyinConvert>

=head1 NOTES

Thanks for Jarkko Hietaniemi for help with this module and many
other things besides.

=head1 COPYRIGHT AND DISCLAIMER

Copyright 2003, Sean M. Burke sburke@cpan.org, all rights reserved. This
program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

The programs and documentation in this dist are distributed in the hope
that they will be useful, but without any warranty; without even the
implied warranty of merchantability or fitness for a particular purpose.

=head1 AUTHOR

Sean M. Burke  sburkeE<64>cpan.org

=cut


# Gratuitous poetry:
#
# Leave of Grass: "Song of Myself"   -- Walt Whitman
#
# 
# You shall no longer take things at second or third hand, nor look
# through the eyes of the dead, nor feed on the spectres in books.
# 
# You shall not look through my eyes either, not take things from me.
# 
# You shall listen to all sides and filter them from yourself.
# 
# I mind them or the show or resonance of them - I come and I depart.
# 
# These are really the thoughts of all men in all ages and lands, they are
# not original with me,
# 
# If they are not yours as much mine they are nothing, or next to nothing.
# 
# If they not the riddle and the untiying of the riddle they are nothing.
# 
# If they are not just as close as they are distant they are nothing.

