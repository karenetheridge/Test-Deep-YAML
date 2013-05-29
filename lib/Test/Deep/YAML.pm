use strict;
use warnings;
package Test::Deep::YAML;
# ABSTRACT: A Test::Deep plugin for comparing YAML-encoded data

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

    use Test::More;
    use Test::Deep;
    use Test::Deep::YAML;

    cmp_deeply(
        "---\nfoo: bar\n",
        yaml({ foo => 'bar' }),
        'YAML-encoded data is correct',
    );

=head1 DESCRIPTION

=for stopwords yaml

This module provides the C<yaml> function to indicate that the target can be
parsed as a YAML string, and should be decoded before being compared to the
indicated expected data.

=head1 FUNCTIONS

=for Pod::Coverage descend diagnostics init

=over 4

=item * yaml

Contains the data which should match corresponding data in the "got" structure
after it has been YAML-decoded.

=back

=head1 SUPPORT

=for stopwords irc

Bugs may be submitted through L<the RT bug tracker|https://rt.cpan.org/Public/Dist/Display.html?Name=Test-Deep-YAML>
(or L<bug-Test-Deep-YAML@rt.cpan.org|mailto:bug-Test-Deep-YAML@rt.cpan.org>).
I am also usually active on irc, as 'ether' at C<irc.perl.org>.

=head1 SEE ALSO

=begin :list

* L<Test::Deep>
* L<Test::Deep::JSON>

=end :list

=cut
