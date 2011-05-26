package DBIx::Class::InflateColumn::BigFloat;

use 5.006;
use strict;
use warnings;
use base qw/DBIx::Class/;
use Math::BigFloat;
use namespace::clean;

# ABSTRACT: Auto-inflate your decimal columns into solid floats


__PACKAGE__->load_components(qw/InflateColumn/);

=method register_column

Chains with the L<DBIx::Class::Row/register_column> method, and sets
up datetime columns appropriately.  This would not normally be
directly called by end users.

=cut

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

=head1 SYNOPSIS

  package Event;
  use base 'DBIx::Class::Core';

  __PACKAGE__->load_components(qw/InflateColumn::BigFloat/);
  __PACKAGE__->add_columns(
    cost => { data_type => 'decmial', size => [7,2] }
  );

=head1 DESCRIPTION

This module causes 'decimal' type columns in your database to automatically wrap
their values with Math::BigFloat. This solves most errors that occur due to
floating point arithmatic upon these values. Keep in mind that while this fixes
the values sourced from the db, you must still clean any values from other
sources (e.g. read from files) manually if you want to be confident that your
calculations are accurate.

=head1 SEE ALSO

L<Math::BigFloat>,
L<DBIx::Class>,
L<DBIx::Class::InflateColumn>.

