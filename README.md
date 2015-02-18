```ruby
x = 1.0 - 0.9 - 0.1
x == 0.0
# WARNING: Testing for equality between inexact floats is ill-advised, when comparing -2.7755575615628914e-17 and 0 (/path/to/file.rb:123)
# => false
```


### Installation and usage

Gemfile:

```ruby
gem "inexact_equality_warning"
```

```ruby
require "inexact_equality_warning"
```
