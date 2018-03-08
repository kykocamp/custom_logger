# CustomLogger

Makes it easier to create custom logs in Rails, using just a simple configuration

## Installation

Add this line to your Rails application's Gemfile:

    gem 'custom_logger'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install custom_logger

## Usage

To setup a logger, create an initializer script such as `[Rails.root]/config/initializers/logger.rb` with:

    CustomLogger.add_logger('test')

This will create a log file located at `log/test.log`.

Then In Rails, you can log by calling the following:

    Rails.logger.test.debug('some debugging here')

The `Rails.` reference can be omitted at the usual places in Rails (e.g. controllers and views).

Note that log_name must not collide with existing method names in Rails logger, so names such as 'debug' or 'info' can not be used. You should try calling `add_logger` in Rails console to test if it is ok or raises an error.

## Advanced

You can assign formatter to loggers directly, or pass the formatter during setup:

    formatter = Proc.new{|severity, time, progname, msg|
      formatted_severity = sprintf("%-5s",severity.to_s)
      formatted_time = time.strftime("%Y-%m-%d %H:%M:%S")
      "[#{formatted_severity} #{formatted_time} #{$$}] #{msg.to_s.strip}\n"
    }
    CustomLogger.add_logger('test', formatter:formatter)
    CustomLogger.add_logger('test2', formatter:formatter)

To set a different path to the log file, use `:path` option.
For example, for setting a different file to each environment use:

    CustomLogger.add_logger('test', formatter:formatter, path:"test_#{Rails.env}")
    CustomLogger.add_logger('test', formatter:formatter, path:"/tmp/test")


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT License (See LICENSE.txt)
