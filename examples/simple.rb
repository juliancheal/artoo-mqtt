require 'artoo'

connection :mqtt, :adaptor => :mqtt, :port => '127.0.0.1:1883'
device :mqtt_greet, :driver => :mqtt, :connection => :mqtt, :topic => "greeting"
device :mqtt_time, :driver => :mqtt, :connection => :mqtt, :topic => "time"

work do
  on mqtt_greet, :greeting => proc { |*value|
    puts "Message: #{value}"
  }

  on mqtt_time, :time => proc { |*value|
    puts "Message: #{value}"
  }

  every(1.seconds) do
    mqtt_greet.publish_message('greeting', "Hello world!")
  end

  every(1.seconds) do
    mqtt_time.publish_message('time', Time.now)
  end

end
