Sequel::Model.plugin(:json_serializer)
Sequel::Model.plugin(:validation_helpers)
Sequel::Model.raise_on_save_failure = true # Do not throw exceptions on failure

DB = 
  case ENV['RACK_ENV']
  when 'test'
    Sequel.connect('sqlite://movies_test.db')
  else
    Sequel.connect(ENV["DB"])
  end

Sequel::Model.db.extension(:pagination)
Sequel::Model.strict_param_setting = false
DB.extension :auto_literal_strings
