class PresentationDay < Sequel::Model
  
  #
  # Associations
  #
  many_to_one :movie

  # 
  # Plugins
  # 
  plugin :timestamps

end
