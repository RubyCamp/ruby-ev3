module EV3
  module Commands
    class UiWrite < Base
      # color: 0-9  
      def set_led(color)
        if !color.is_a?(Integer) || !(0..9).include?(color)
          raise "invalid color: #{color.inspect}"
        end
        @message +=
          ByteCodes::UI_WRITE.bytes +
          [UiWriteSubcodes::LED] +
          [color]
        return self
      end
    end
  end
end
