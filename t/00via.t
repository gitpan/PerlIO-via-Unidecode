
# 
# "[Samuel] Johnson's aesthetic judgments are almost invariably subtle or
# solid or bold; they always have some good quality to recommend them,
# except one: they are never right." -Lytton Strachey
#

use Test;
BEGIN {plan tests => 2};

ok 1;
require PerlIO::via::Unidecode;
$PerlIO::via::Unidecode::VERSION
 and print "# Pod::Perldoc version $PerlIO::via::Unidecode::VERSION\n";
$Text::Unidecode::VERSION
 and print "# Text::Unidecode version $Text::Unidecode::VERSION\n";
require PerlIO::via;
$PerlIO::via::VERSION
 and print "# PerlIO::via version $PerlIO::via::VERSION\n";

print "# Running under perl version $] for $^O",
      (chr(65) eq 'A') ? "\n" : " in a non-ASCII world\n";
print "# Win32::BuildNumber ", &Win32::BuildNumber(), "\n"
      if defined(&Win32::BuildNumber) and defined &Win32::BuildNumber();
print "# MacPerl verison $MacPerl::Version\n"
      if defined $MacPerl::Version;
printf "# Current time local: %s\n# Current time GMT:   %s\n",
      scalar(   gmtime($^T)), scalar(localtime($^T));
print "# Using Test.pm version ", $Test::VERSION || "nil", "\n";

ok 1;




# Gratuitous poetry:
#
# "Sailing to Byzantium"
# 
# William Butler Yeats, 1927
# 
# That is no country for old men. The young
# In one another's arms, birds in the trees
# - Those dying generations - at their song,
# The salmon falls, the mackerel-crowded seas,
# Fish, flesh or fowl, commend all summer long
# Whatever is begotten, born and dies.
# Caught in that sensual music all neglect
# Monuments of unaging intellect.
# 
# An aged man is but a paltry thing,
# A tattered coat upon a stick, unless
# Soul clap its hands and sing, and louder sing
# For every tatter in its mortal dress,
# Nor is there singing school but studying
# Monuments of its own magnificence;
# And therefore I have sailed the seas and come
# To the holy city of Byzantium.
# 
# O sages standing in God's holy fire
# As in the gold mosaic of a wall,
# Come from the holy fire, perne in a gyre,
# And be the singing-masters of my soul.
# Consume my heart away; sick with desire
# And fastened to a dying animal
# It knows not what it is; and gather me
# Into the artifice of eternity.
# 
# Once out of nature I shall never take
# My bodily form from any natural thing,
# But such a form as Grecian goldsmiths make
# Of hammered gold and gold enamelling
# To keep a drowsy emperor awake;
# Or set upon the golden bough to sing
# To lords and ladies of Byzantium
# Of what is past, or passing, or to come.

