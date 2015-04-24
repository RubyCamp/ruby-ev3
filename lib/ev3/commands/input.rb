# see:
#   https://github.com/mindboards/ev3sources/blob/master/lms2012/c_input/source/c_input.c
module EV3
  module Commands
    class Input < Base
      DO_NOT_CHANGE_TYPE = "\x00"
      CHANGE_TYPE = "\x01"
      GLOBAL_VAR_INDEX4 = "\x64"
      LAYER = "\x00"
      SENSORS = {
        "1"   => "\x00",
        "2"   => "\x01",
        "3"   => "\x02",
        "4"   => "\x03",
        "ALL" => "\xFF",
      }
      @@last_mode_type = {
        "1" => nil,
        "2" => nil,
        "3" => nil,
        "4" => nil,
      }

      def list_sensors
        @global_variables = "\x00"
        @local_variables = "\x05"
        @message +=
          ByteCodes::INPUT_DEVICE_LIST.bytes +
          [SENSORS.count] +
          GLOBAL_VAR_INDEX0.bytes +
          GLOBAL_VAR_INDEX4.bytes
        return self
      end

      def clear_all
        @message +=
          ByteCodes::INPUT_DEVICE.bytes +
          InputSubCodes::CLEAR_ALL.bytes +
          LAYER.bytes
        return self
      end

      def clear_changes(sensor)
        @message +=
          ByteCodes::INPUT_DEVICE.bytes +
          InputSubCodes::CLR_CHANGES.bytes +
          LAYER.bytes +
          SENSORS[sensor].bytes
        return self
      end

      def sensor(sensor, mode = 0)
        @global_variables = "\x00"
        @local_variables = "\x04"
        if(!@@last_mode_type[sensor].nil? && @@last_mode_type[sensor] != MODE)
          change_type = CHANGE_TYPE
        else
          change_type = DO_NOT_CHANGE_TYPE
        end

        @message +=
          ByteCodes::INPUT_DEVICE.bytes +
          InputSubCodes::READY_SI.bytes +
          LAYER.bytes +
          SENSORS[sensor].bytes +
          change_type.bytes +
          mode.chr.bytes +
          ONE_DATA_SET.bytes +
          GLOBAL_VAR_INDEX0.bytes
        return self
      end
    end
  end
end
