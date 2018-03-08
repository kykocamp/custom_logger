require 'helper'
require 'custom_logger'

require 'logger'
require 'active_support/core_ext/string'

# Dummy class to avoid loading Rails
module Rails
  def self.root
    Pathname.new('./spec/')
  end
end

describe CustomLogger do
  it 'has version' do
    CustomLogger.const_get('VERSION').wont_be_empty
  end

  describe '.add_logger' do
    it 'error if name already in use as method name to loggers' do
      lambda { CustomLogger.add_logger('object_id')  }.must_raise RuntimeError
    end
    it 'defines a instance method in Rails Logger class linking to custom logger' do
      rails_logger_klass = Class.new
      CustomLogger.stubs(:get_rails_logger_class).returns(rails_logger_klass)

      logger = Logger.new('test')
      Logger.stubs(:new).returns(logger)

      CustomLogger.add_logger('testing').must_equal logger

      rails_logger_klass.new.payment.must_equal logger
    end
    it 'assigns formatter to custom logger' do
      rails_logger_klass = Class.new
      CustomLogger.stubs(:get_rails_logger_class).returns(rails_logger_klass)

      logger = Logger.new('test')
      Logger.stubs(:new).returns(logger)

      formatter = mock('formatter')
      CustomLogger.add_logger('testing2', {formatter:formatter}).must_equal logger

      rails_logger_klass.new.fb.must_equal logger
      logger.formatter.must_equal formatter
    end
  end

  describe '.get_path' do
    it '' do
      CustomLogger.send(:get_path,'parser').to_s.must_equal './spec/log/parser.log'
    end
    it 'uses path as file path different to name' do
      CustomLogger.send(:get_path, 'my_model', 'my_model').to_s.must_equal './spec/log/my_model.log'
    end
    it 'uses path as file path (relative to Rails root) different to name' do
      CustomLogger.send(:get_path, 'my_model',' my_model').to_s.must_equal './spec/log/my_model.log'
    end
    it 'uses path as file path as is if it contains slash' do
      CustomLogger.send(:get_path, 'user', './model_user').to_s.must_equal './model_user.log'
    end
    it 'does not append .log if path already ends with it' do
      CustomLogger.send(:get_path, 'user', './model_user.log').to_s.must_equal './model_user.log'
    end
  end
end
