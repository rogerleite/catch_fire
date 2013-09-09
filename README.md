# CatchFire

Catch a Fire is a rubygem to capture and process exception, using a simple and awesome DSL.

## Installation

Add this line to your application's Gemfile:

    gem 'catch_fire'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install catch_fire

## Usage

Some code here.

```
  class TestCustomError < StandardError; end

  CatchFire.configure do
    conditions do
      on exception.is_a?(ArgumentError) do
        raise TestCustomError.new(exception)
      end
      on exception.message =~ /weird/ do
        raise TestCustomError.new(exception)
      end
    end
  end

  CatchFire.catch_a_fire do
    # your code here
  end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Uses MIT license.
