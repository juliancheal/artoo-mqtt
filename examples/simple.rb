require 'artoo'

connection :mqtt, :adaptor => :mqtt, :port => '127.0.0.1:1883'
device :mqtt_greet, :driver => :mqtt, :connection => :mqtt, :topic => "greeting"

work do
  on mqtt_greet, :greeting => proc { |*value|
    puts "Message: #{value}"
  }

  counter = 0

  every(1.seconds) do
    mqtt_greet.publish_message('greeting', "Hello #{counter+=1}")
  end

end
