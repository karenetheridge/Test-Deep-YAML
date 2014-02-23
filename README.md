# NAME

Test::Deep::YAML - A Test::Deep plugin for comparing YAML-encoded data

# VERSION

version 0.002

# SYNOPSIS

    use Test::More;
    use Test::Deep;
    use Test::Deep::YAML;

    cmp_deeply(
        "---\nfoo: bar\n",
        yaml({ foo => 'bar' }),
        'YAML-encoded data is correct',
    );

# DESCRIPTION

This module provides the `yaml` function to indicate that the target can be
parsed as a YAML string, and should be decoded before being compared to the
indicated expected data.

# FUNCTIONS

## yaml

Contains the data which should match corresponding data in the "got" structure
after it has been YAML-decoded.

# SUPPORT

Bugs may be submitted through [the RT bug tracker](https://rt.cpan.org/Public/Dist/Display.html?Name=Test-Deep-YAML)
(or [bug-Test-Deep-YAML@rt.cpan.org](mailto:bug-Test-Deep-YAML@rt.cpan.org)).
I am also usually active on irc, as 'ether' at `irc.perl.org`.

# SEE ALSO

- [Test::Deep](https://metacpan.org/pod/Test::Deep)
- [Test::Deep::JSON](https://metacpan.org/pod/Test::Deep::JSON)

# AUTHOR

Karen Etheridge <ether@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Karen Etheridge.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
