# require 5.008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'PerlIO::via::Unidecode',
    'VERSION_FROM'  => 'lib/PerlIO/via/Unidecode.pm', # finds $VERSION
    'ABSTRACT_FROM' => 'lib/PerlIO/via/Unidecode.pm',
    'dist'        => { COMPRESS => 'gzip -5f', SUFFIX => 'gz', },
    'PREREQ_PM' => {
        'strict'  => 0,
        'utf8'   => 0,
        'Text::Unidecode' => 0,
        'Text::Unidecode' => 0,
    },
    
);

package MY;

sub libscan
{ # Determine things that should *not* be installed
    my($self, $path) = @_;
    return '' if $path =~ m/~/;
    $path;
}

__END__
