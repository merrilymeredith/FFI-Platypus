use strict;
use warnings;
use Test::More;
use FFI::Platypus;
use JSON::PP;
BEGIN { eval q{ use YAML () } };

sub xdump ($)
{
  my($object) = @_;
  note(YAML->can('Dump') ? YAML::Dump($object) : JSON::PP->new->allow_unknown->encode($object));
}

my $ffi = FFI::Platypus->new;

my @basic_types = (qw( float double opaque ), map { ("uint$_", "sint$_") } (8,16,32,64));

plan tests => scalar @basic_types;

foreach my $basic (@basic_types)
{
  subtest $basic => sub {
    plan tests => 6;
  
    eval { $ffi->custom_type($basic, "foo_${basic}_1", sub {}, undef, undef) };
    is $@, '', 'ffi.custom_type 1';
    xdump({ "${basic}_1" => $ffi->type_meta("foo_${basic}_1") });

    eval { $ffi->custom_type($basic, "foo_${basic}_2", sub {}, undef, [1,2,3]) };
    is $@, '', 'ffi.custom_type 2';
    xdump({ "${basic}_2" => $ffi->type_meta("foo_${basic}_2") });

    eval { $ffi->custom_type($basic, "bar_${basic}_1", undef, sub {}, undef) };
    is $@, '', 'ffi.custom_type 1';
    xdump({ "${basic}_1" => $ffi->type_meta("bar_${basic}_1") });

    eval { $ffi->custom_type($basic, "bar_${basic}_2", undef, sub {}, [1,2,3]) };
    is $@, '', 'ffi.custom_type 2';
    xdump({ "${basic}_2" => $ffi->type_meta("bar_${basic}_2") });

    eval { $ffi->custom_type($basic, "baz_${basic}_1", sub {}, sub {}, undef) };
    is $@, '', 'ffi.custom_type 1';
    xdump({ "${basic}_1" => $ffi->type_meta("baz_${basic}_1") });

    eval { $ffi->custom_type($basic, "baz_${basic}_2", sub {}, sub {}, [1,2,3]) };
    is $@, '', 'ffi.custom_type 2';
    xdump({ "${basic}_2" => $ffi->type_meta("baz_${basic}_2") });

  };
}
