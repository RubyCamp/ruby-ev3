# see:
#   https://github.com/mindboards/ev3sources/blob/master/lms2012/c_output/source/c_output.c
module EV3
  module Commands
    class Output < Base
      MOTORS = {"A" => "\x01", "B" => "\x02", "C" => "\x04", "D" => "\x08"}
      ONE_MOTOR = {"A" => "\x00", "B" => "\x01", "C" => "\x02", "D" => "\x03"}
      BRAKE = "\x01"
      NO_BRAKE = "\x00"

      def ready(*motors)
        all_motors = union_motors(*motors)
        @message += ByteCodes::OUTPUT_READY.bytes +
        Layers::LAYER_0.bytes +
        [all_motors]
        return self
      end

      def start(*motors)
        all_motors = union_motors(*motors)
        @message += ByteCodes::OUTPUT_START.bytes +
        Layers::LAYER_0.bytes +
        [all_motors]
        return self
      end

      def speed(velocity, *motors)
        all_motors = union_motors(*motors)
        @message += ByteCodes::OUTPUT_SPEED.bytes +
        Layers::LAYER_0.bytes +
        [all_motors] +
        ArgumentSize::BYTE.bytes +
        [velocity]
        return self
      end

      def reverse_polarity(direction, *motors)
        all_motors = union_motors(*motors)
        @message += ByteCodes::OUTPUT_POLARITY.bytes +
        Layers::LAYER_0.bytes +
        [all_motors] +
        [direction]
        return self
      end

      def reset(*motors)
        all_motors = union_motors(*motors)
        @message += ByteCodes::OUTPUT_RESET.bytes +
        Layers::LAYER_0.bytes +
        [all_motors]
        return self
      end

      def step_velocity(velocity, degrees_rotation , degrees_precision, *motors)
        all_motors = union_motors(*motors)
        degrees_rotation =  [degrees_rotation].pack("v*")
        degrees_precision =  [degrees_precision].pack("v*")
        velocity = [velocity].pack("v*")
        @message += ByteCodes::OUTPUT_STEP_SPEED.bytes +
        Layers::LAYER_0.bytes +
        [all_motors] +
        ArgumentSize::BYTE.bytes +
        velocity[0].bytes +
        velocity[1].bytes +
        ArgumentSize::SHORT.bytes +
        degrees_rotation[0].bytes +
        degrees_rotation[1].bytes +
        ArgumentSize::SHORT.bytes +
        degrees_precision[0].bytes+
        degrees_precision[1].bytes +
        BRAKE.bytes
        return self
      end

      def stop(force_break, *motors)
        all_motors = union_motors(*motors)
        break_bytes = force_break ? BRAKE.bytes : NO_BRAKE.bytes
        @message += ByteCodes::OUTPUT_STOP.bytes +
        Layers::LAYER_0.bytes +
        [all_motors] +
        break_bytes
        return self
      end

      def get_count(motor)
        @local_variables = "\x04"
        @global_variables = "\x00"
        @message += ByteCodes::OUTPUT_GET_COUNT.bytes +
        Layers::LAYER_0.bytes +
        ONE_MOTOR[motor.capitalize].bytes +
        GLOBAL_VAR_INDEX0.bytes
        return self
      end

      def read(motor)
        @local_variables = "\x04"
        @global_variables = "\x00"
        @message += ByteCodes::OUTPUT_READ.bytes +
        Layers::LAYER_0.bytes +
        ONE_MOTOR[motor.capitalize].bytes +
        ONE_DATA_SET.bytes +
        GLOBAL_VAR_INDEX0.bytes
        return self
      end

      def union_motors(*motors)
        return NotImplementedError if(motors.nil? || motors.size < 1)
        all_motors = MOTORS[motors[0].capitalize].bytes[0]
        motors.each do |motor|
          all_motors =  (MOTORS[motor.capitalize].bytes[0] | all_motors)
        end
        return all_motors
      end
    end
  end
end
