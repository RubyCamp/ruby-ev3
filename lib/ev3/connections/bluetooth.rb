require_relative 'base'
require 'rubyserial'

module EV3
  module Connections
    class Bluetooth < Base
      attr_reader :device

      def initialize(device)
        super()
        @device = device
      end

      def connect
        @serial_port = Serial.new(@device, 9600)
      end

      def disconnect
        @serial_port.close
      end

      def read(bytes)
        return @serial_port.read(bytes)
      end

      def write(command)
        @serial_port.write command
      end
    end
  end
end
