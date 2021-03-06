use strict;
use warnings;
package Test::Deep::YAML;
# vim: set ts=8 sts=4 sw=4 tw=115 et :
# ABSTRACT: A Test::Deep plugin for comparing YAML-encoded data
# KEYWORDS: testing tests plugin YAML data

our $VERSION = '0.005';

use Exporter 5.57 'import';
our @EXPORT = qw(yaml);

sub yaml
{
    my ($expected) = @_;
    return Test::Deep::YAML::Object->new($expected);
}

package # hide from PAUSE
    Test::Deep::YAML::Object;

our $VERSION = '0.005';

use parent 'Test::Deep::Cmp';
use Try::Tiny ();
use YAML ();

sub init
{
    my ($self, $expected) = @_;
    $self->{val} = $expected;
}

sub descend
{
    my ($self, $got) = @_;

    my $data = Try::Tiny::try
    {
        YAML::Load($got);
    }
    Try::Tiny::catch
    {
        chomp($self->{error_message} = $_);
        undef;
    };

    return 0 if not $data or $self->{error_message};

    return Test::Deep::wrap($self->{val})->descend($data);
}

sub diagnostics
{
    my ($self, $where, $last) = @_;
    return $self->{error_message}
        || $self->{val}->diagnostics($where, $last);
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

=head2 yaml

Contains the data which should match corresponding data in the "got" structure
after it has been YAML-decoded.

=head1 SEE ALSO

=for :list
* L<Test::Deep>
* L<Test::Deep::JSON>

=cut
