module EV3
  module Connections
    class Base
      def connect
        raise NotImplementedError
      end

      def write(command)
        raise NotImplementedError
      end

      def read(bytes)
        raise NotImplementedError
      end

      def disconnect
        raise NotImplementedError
      end
    end
  end
end
