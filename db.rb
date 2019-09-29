DB = 
  case ENV['RACK_ENV']
  when 'test'
    Sequel.connect('sqlite://movies_test.db')
  else
    Sequel.connect(ENV["DB"])
  end