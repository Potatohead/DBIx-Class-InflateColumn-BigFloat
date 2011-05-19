package DBIx::Class::InflateColumn::BigFloat;

our $VERSION = '0.01';

use 5.006;
use strict;
use warnings;
use base qw/DBIx::Class/;
use Math::BigFloat;
use namespace::clean;

__PACKAGE__->load_components(qw/InflateColumn/);

sub register_column {
  my ($self, $column, $info, @rest) = @_;

  $self->next::method($column, $info, @rest);

  return unless $info->{data_type} eq 'decimal';

  $self->inflate_column(
    $column => {
      inflate => sub {
        my ( $value, $obj ) = @_;

        return Math::BigFloat->new($value);
      },
      deflate => sub {
        return shift;
      },
    }
  );
}

1; # End of DBIx::Class::InflateColumn::BigFloat

__END__

=head1 NAME

DBIx::Class::InflateColumn::BigFloat - Auto-inflate your decimal columns into
solid floats

=head1 VERSION

Version 0.01

=cut



=head1 SYNOPSIS

  package Event;
  use base 'DBIx::Class::Core';
  
  __PACKAGE__->load_components(qw/InflateColumn::BigFloat/);
  __PACKAGE__->add_columns(
    cost => { data_type => 'decmial', size => [7,2] }
  );

=head1 DESCRIPTION


=head2 register_column


=head1 AUTHOR

Christopher Mckay, C<< <potatohead at potatolan.com> >>


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Christopher Mckay.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.
