module EV3
  module Commands
    class Base
      ONE_DATA_SET = "\x01"
      GLOBAL_VAR_INDEX0 = "\x60"
      SEQUENCE_LOCAL = "\x00" #NOT NECESSARY
      SEQUENCE_GLOBAL = "\x00" #NOT NECESSARY

      def initialize(connection)
        @message = []
        @connection = connection
        @local_variables = "\x00"
        @global_variables = "\x00"
      end

      def send_command
        @message = SEQUENCE_LOCAL.bytes + SEQUENCE_GLOBAL.bytes +  @message
        @message = [@message.size].pack("v").bytes + @message
        write_message
        return self
      end

      def write_message
        @connection.write @message.pack("C*")
      end

      def get_data(format = nil )
        begin
          response_size = ReplyCodes::RESPONSE_BUFFER + @local_variables.bytes[0].to_i
          response = @connection.read(response_size)
          if (response == "")
            return get_data(format)
          end
          if @local_variables.bytes[0] == 0
            return response[ReplyCodes::REPLY].unpack("H*")[0].to_i
          elsif  @local_variables.bytes[0] == 4
            if(format.nil?)
              return response[ReplyCodes::RESPONSE_BUFFER..(response.size)].unpack("e")[0]
            else
              return response[ReplyCodes::RESPONSE_BUFFER..(response.size)].unpack(format)[0]
            end
          elsif  @local_variables.bytes[0] == 5
            return response[ReplyCodes::RESPONSE_BUFFER..(response.size)]
          end
        rescue
          write_message
          get_data
        end
      end

      def command_type(command)
        @message = command.bytes + @local_variables.bytes + @global_variables.bytes + @message
        return self
      end
    end
  end
end
