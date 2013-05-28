use strict;
use warnings;
package Test::Deep::YAML;
# ABSTRACT: ...

use parent 'Test::Deep::Cmp';
use Exporter 'import';
use Test::Deep;
use Try::Tiny;
use YAML 'Load';

our @EXPORT = qw(yaml);

sub yaml
{
    my ($expected) = @_;
    return __PACKAGE__->new($expected);
}

sub init
{
    my ($self, $expected) = @_;
    $self->{val} = $expected;
}

sub descend
{
    my ($self, $got) = @_;

    my $data = try
    {
         Load($got);
    }
    catch
    {
        chomp($self->{error_message} = $_);
        undef;
    };

    return 0 if not $data or $self->{error_message};

    return Test::Deep::wrap($self->{val})->descend($data);
}

sub diagnostics
{
    my $self = shift;
    return $self->{error_message};
}

1;
__END__

=pod

=head1 SYNOPSIS

...

=head1 DESCRIPTION


=head1 FUNCTIONS/METHODS

=begin :list

* C<foo>

=end :list

...

=head1 SUPPORT

=for stopwords irc

Bugs may be submitted through L<the RT bug tracker|https://rt.cpan.org/Public/Dist/Display.html?Name=Test-Deep-YAML>
(or L<bug-Test-Deep-YAML@rt.cpan.org|mailto:bug-Test-Deep-YAML@rt.cpan.org>).
I am also usually active on irc, as 'ether' at C<irc.perl.org>.

=head1 ACKNOWLEDGEMENTS

...

=head1 SEE ALSO

...

=cut
