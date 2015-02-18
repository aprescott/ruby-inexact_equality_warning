def capturing_stderr(&block)
  original_stderr = $stderr
  $stderr = output_capturer = StringIO.new
  begin
    yield
  ensure
    $stderr = original_stderr
  end
  output_capturer.string
end

RSpec.describe EqualityWarning do
  def expect_warning(x, y)
    expect(capturing_stderr { x == y }).to include("WARNING: Testing for equality with inexact floats is ill-advised, when comparing #{x} and #{y} (#{__FILE__}:#{__LINE__}:in `block in #{__method__}'")
  end

  def expect_no_warning(x, y)
    expect(capturing_stderr { x == y }).to_not include("WARNING")
  end

  [
    1.0, 1,
    1.0, 2**1000,
    1.0, Rational(1, 2),
    1.0, Complex(1, 2),
    1, 1.0,
    Rational(1, 2), 1.0,
    2**1000, 1.0,
    Complex(1, 2), 1.0,
  ].each_slice(2) do |x, y|
    specify { expect_warning(x, y) }
  end

  [
    1, 2**1000,
    1, Rational(1, 2),
    1, Complex(1, 2),
    1, "anything",
    2**1000, 1,
    2**1000, Rational(1, 2),
    2**1000, Complex(1, 2),
    2**1000, "anything",
    Rational(1, 2), 1,
    Rational(1, 2), 2**1000,
    Rational(1, 2), Complex(1, 2),
    Rational(1, 2), "anything",
    Complex(1, 2), 1,
    Complex(1, 2), 2**1000,
    Complex(1, 2), Rational(1, 2),
    Complex(1, 2), "anything",
    "anything", 1,
    "anything", 2**1000,
    "anything", Rational(1, 2),
    "anything", Complex(1, 2),
    1.0, "anything",
    "anything", 1.0,
  ].each_slice(2) do |x, y|
    specify { expect_no_warning(x, y) }
  end

  it "is included on all Numeric leaf subclasses" do
    constants = Object.constants.map { |sym| Object.const_get(sym) }
    prepended_classes = constants.select { |klass| klass.is_a?(Class) && klass.ancestors.include?(EqualityWarning) }
    numeric_classes = constants.select { |klass| klass.is_a?(Class) && klass < Numeric }

    expect(prepended_classes).to eq([Fixnum, Float, Bignum, Rational, Complex])
    # compact all `numeric_classes` by removing any that are subclasses of another class in `numeric_classes`
    expect(numeric_classes.reject { |klass| numeric_classes.any? { |other_class| other_class < klass } }).to eq(prepended_classes)
  end
end

=begin
# test case permutations generation:

test_values = {
  Fixnum => "1",
  Float => "1.0",
  Bignum => "2**1000",
  Rational => "Rational(1, 2)",
  Complex => "Complex(1, 2)",
  String => %~"anything"~
}
[Float, Fixnum, Bignum, Rational, Complex, String].permutation(2).to_a.map do |x, y|
  [test_values[x], test_values[y]]
end.each do |x, y|
  puts "#{x}, #{y},"
end
=end
