# it would be good to use #inexact? here -- https://bugs.ruby-lang.org/issues/5321
module EqualityWarning
  def ==(other)
    warn "WARNING: Testing for equality between inexact floats is ill-advised, when comparing #{self} and #{other} (#{caller.first})" if self.is_a?(Float) || other.is_a?(Float)
    super
  end
end

# classes that are leaf nodes of all subclasses of Numeric
[Fixnum, Float, Bignum, Rational, Complex].each { |klass| klass.prepend(EqualityWarning) }
