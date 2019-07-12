use strict;
use warnings;
use Test::More;
use FFI::Platypus;
use FFI::CheckLib qw( find_lib );
use FFI::Platypus::Memory qw( malloc free );

my $libtest = find_lib lib => 'test', symbol => 'f0', libpath => 't/ffi';

{
  package
    FooRecord;
  use FFI::Platypus::Record;
  record_layout(qw(
    string(16) name
    sint32     value
  ));
}

subtest 'is a reference' => sub {
  my $ffi = FFI::Platypus->new( api => 1, experimental => 1 );
  $ffi->lib($libtest);

  $ffi->type("record(FooRecord)" => 'foo_record_t');
  my $get_name  = $ffi->function( foo_value_get_name    => [ 'foo_record_t' ] => 'string' );
  my $get_value = $ffi->function( foo_value_get_value   => [ 'foo_record_t' ] => 'sint32' );
  my $create    = $ffi->function( foo_value_create      => [ 'string', 'sint32' ] => 'foo_record_t' );

  subtest 'argument' => sub {

    plan skip_all => 'not working yet';

    my $rv = FooRecord->new(
      name => "hello",
      value => 42,
    );

    is $get_name->call($rv), "hello";
    is $get_value->call($rv), 42;
  
  };

};

done_testing;
