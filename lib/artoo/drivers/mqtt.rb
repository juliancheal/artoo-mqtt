require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # The mqtt driver behaviors
    class Mqtt < Driver
      attr_reader :topic
      attr_accessor :topics

      COMMANDS = [:publish_message, :add_topics].freeze

      # Start driver and any required connections
      def start_driver
        @topic = @additional_params[:topic]
        @topics = []
        connection.subscribe(@topic)
        connection.start
        begin
          connection.subscription(@topic) do |message|
            publish(event_topic_name(@topic), message)
          end
          # every(interval) do
          #   handle_message_events
          # end
          super
        rescue Exception => e
          Logger.error "Error starting Mqtt driver!"
          Logger.error e.message
          Logger.error e.backtrace.inspect
        end
      end

      def handle_message_events
        connection.subscription(@topic) do |message|
          publish(event_topic_name(@topic), message)
        end
      end

      def publish_topics(data)
        publish(event_topic_name(data), data)
      end

      def add_topics(topics)
        @topics = topics
        connection.subscribes(@topics)
      end

      def publish_message(topic, data)
        connection.publish(topic,data)
      end

    end
  end
end
