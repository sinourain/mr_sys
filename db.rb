Sequel.extension :pg_array, :pg_json, :pg_json_ops, :pg_inet
Sequel::Model.plugin(:json_serializer)
Sequel::Model.plugin(:validation_helpers)
Sequel::Model.raise_on_save_failure = true # Do not throw exceptions on failure
DB = 
  case ENV['RACK_ENV']
  when 'test'
    Sequel.connect('postgres://postgres@localhost/mr_sys_test')
  else
    Sequel.connect(ENV["DATABASE_URL"])
  end
Sequel::Model.db.extension(:pagination)
Sequel::Model.strict_param_setting = false
DB.extension :pg_array, :pg_json, :connection_validator
DB.extension :auto_literal_strings
DB.pool.connection_validation_timeout = -1