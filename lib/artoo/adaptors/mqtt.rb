require 'artoo/adaptors/adaptor'

module Artoo
  module Adaptors
    # Connect to a mqtt device
    # @see device documentation for more information
    class Mqtt < Adaptor
      attr_reader :mqtt

      # Number of retries when connecting
      RETRY_COUNT = 5

      # Creates a connection with device
      # @return [Boolean]
      def connect
        @retries_left = RETRY_COUNT
        require 'iris_mqtt' unless defined?(::Mqtt)
        begin
          @mqtt = Iris::MQTT::Client.connect("mqtt://#{port.host}:#{port.port}")
          super
          return true
        rescue Errno::EBUSY, Errno::ECONNREFUSED => e
          @retries_left -= 1
          if @retries_left > 0
            retry
          else
            Logger.error e.message
            Logger.error e.backtrace.inspect
            return false
          end
        end
      end

      # Closes connection with device
      # @return [Boolean]
      def disconnect
        mqtt.disconnect()
        super
      end

      # Name of device
      # @return [String]
      def name
        "mqtt"
      end

      # Version of device
      # @return [String]
      def version
        Artoo::Mqtt::VERSION
      end

      # Uses method missing to call device actions
      # @see device documentation
      def method_missing(method_name, *arguments, &block)
        mqtt.send(method_name, *arguments, &block)
      end
    end
  end
end
