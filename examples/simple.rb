require 'artoo'

connection :mqtt, :adaptor => :mqtt, :port => '127.0.0.1:1883'
device :messanger, :driver => :mqtt, :connection => :mqtt, :topic => "#"

work do  
  on messanger, :time => proc { |*value|
    puts "Topic: #{value[1][0]}, Message: #{value[1][1]}"
  }
  
  on messanger, :temperature => proc { |*value|
    puts "Topic: #{value[1][0]}, Message: #{value[1][1]}°C"
  }
  
  # Seems to only work if we publish blank messages
  # to each topic first
  messanger.publish_message('time', "")
  messanger.publish_message('temperature', "")
  
  every(1.seconds) do
    messanger.publish_message('time', "The time is: #{Time.now}")
  end
  
  every(1.seconds) do
    messanger.publish_message('temperature', "21")
  end
end