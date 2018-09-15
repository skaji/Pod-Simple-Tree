package Pod::Simple::Tree;
use strict;
use warnings;

our $VERSION = '0.001';

use parent 'Pod::Simple';

{
    package Pod::Simple::Tree::Node;
    sub new {
        my ($class, $klass, $attr) = @_;
        bless {
            class => $klass,
            attr => $attr,
            children => [],
        }, $class;
    }
    sub class {
        my $self = shift;
        $self->{class};
    }
    sub children {
        my $self = shift;
        @{$self->{children}};
    }
    sub _text {
        my ($self, $text) = @_;
        my $_text = Pod::Simple::Tree::Node->new('text');
        $_text->_child($text);
        push @{$self->{children}}, $_text;
    }
    sub _child {
        my ($self, $node) = @_;
        push @{$self->{children}}, $node;
    }
}

my $SEC = __PACKAGE__;

sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    $self->{$SEC} = {
        tree => undef,
        stack => [],
    };
    $self;
}

sub tree {
    my $self = shift;
    $self->{$SEC}{tree};
}

sub push :method {
    my ($self, $node) = @_;
    my $stack = $self->{$SEC}{stack};
    $stack->[-1]->_child($node) if @$stack;
    push @$stack, $node;
}

sub pop :method {
    my $self = shift;
    my $pop = pop @{$self->{$SEC}{stack}};
    if (!@{$self->{$SEC}{stack}}) {
        $self->{$SEC}{tree} = $pop;
    }
}

sub _handle_element_start {
    my ($self, $elem, $attr) = @_;
    $self->push(Pod::Simple::Tree::Node->new($elem, $attr));
}

sub _handle_element_end {
    my ($self, $elem, $value) = @_;
    $self->pop;
}

sub _handle_text {
    my ($self, $text) = @_;
    $self->{$SEC}{stack}[-1]->_text($text);
}

1;
__END__

=encoding utf-8

=head1 NAME

Pod::Simple::Tree - get pod as tree

=head1 SYNOPSIS

  use Pod::Simple::Tree;

  my $pod = Pod::Simple::Tree->new;
  $pod->parse_file($0);

  use Data::Dumper;
  print Dumper $pod->tree;

=head1 DESCRIPTION

Pod::Simple::Tree gets pod as tree.

=head1 SEE ALSO

L<Pod::Simple::SimpleTree>

=head1 AUTHOR

Shoichi Kaji <skaji@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2018 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
