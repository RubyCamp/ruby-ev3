module EV3
  module Commands
    class Sound < Base
      def stop_sound
        @message +=
          ByteCodes::SOUND.bytes +
          [SoundSubCodes::BREAK]         
        return self
      end
      
      def set_tone(volume, freq, duration)
        @message +=
          ByteCodes::SOUND.bytes +
          [SoundSubCodes::TONE] +
          [volume] +
          ArgumentSize::SHORT.bytes +
          [freq].pack("v*").bytes +
          ArgumentSize::SHORT.bytes +
          [duration].pack("v*").bytes         
        return self
      end
    end
  end
end
