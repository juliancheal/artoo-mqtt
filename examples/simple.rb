require 'artoo'

connection :mqtt, :adaptor => :mqtt, :port => '127.0.0.1:1883'
device :listener, :driver => :mqtt, :connection => :mqtt, :topic => "#"

work do  
  on listener, :greetings => proc { |*value|
    puts "Topic: #{value[1][0]}, Message: #{value[1][1]}"
  }

  on listener, :temperature => proc { |*value|
    puts "Topic: #{value[1][0]}, Message: #{value[1][1]}°C"
  }
end