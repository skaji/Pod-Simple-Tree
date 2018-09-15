[![Build Status](https://travis-ci.org/skaji/Pod-Simple-Tree.svg?branch=master)](https://travis-ci.org/skaji/Pod-Simple-Tree)
[![AppVeyor Status](https://ci.appveyor.com/api/projects/status/github/skaji/Pod-Simple-Tree?branch=master&svg=true)](https://ci.appveyor.com/project/skaji/Pod-Simple-Tree)

# NAME

Pod::Simple::Tree - get pod as tree

# SYNOPSIS

    use Pod::Simple::Tree;

    my $pod = Pod::Simple::Tree->new;
    $pod->parse_file($0);

    use Data::Dumper;
    print Dumper $pod->tree;

# DESCRIPTION

Pod::Simple::Tree gets pod as tree.

# SEE ALSO

[Pod::Simple::SimpleTree](https://metacpan.org/pod/Pod::Simple::SimpleTree)

# AUTHOR

Shoichi Kaji <skaji@cpan.org>

# COPYRIGHT AND LICENSE

Copyright 2018 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
