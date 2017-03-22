require_relative 'commands/load_commands'

module EV3
  class Brick
    def initialize(connection)
      @connection = connection
    end

    # EV3本体に接続する
    def connect
      @connection.connect
    end

    # EV3本体との接続を切断する
    def disconnect
      @connection.disconnect unless @connection.nil?
    end

    # EV3が入力可能となるまで待つ
    def motor_ready(*motors)
      Commands::Output.new(@connection).
        command_type(CommandType::DIRECT_COMMAND_REPLY).
        ready(*motors).
        send_command.
        get_data
    end

    # 指定したモーターのタコメーターの値（回転数）を取得する
    def get_count(motor)
      Commands::Output.new(@connection).
        get_count(motor).
        command_type(CommandType::DIRECT_COMMAND_REPLY).
        send_command.
        get_data("s<")
    end

    # 接続しているセンサーの情報を取得する
    # 戻り値は、ポート1から4の順に下記の左辺を連結した文字列になる
    #
    #   "\x20" =>  gyro
    #   "\x1D" =>  color
    #   "\x1E" =>  distance
    #   "\x10" =>  touch
    #   "\x7E" =>  empty
    def list_inputs
      Commands::Input.new(@connection).
        list_sensors.command_type(CommandType::DIRECT_COMMAND_REPLY).
        send_command.
        get_data
    end

    # デバイスの情報をクリアする (e.c. counters, angle, ...)
    def clear_all
      Commands::Input.new(@connection).
        clear_all.
        command_type(CommandType::DIRECT_COMMAND_NO_REPLY).
        send_command
    end

    # 指定したセンサーの情報をクリアする
    def clear_changes(sensor)
      Commands::Input.new(@connection).
        clear_changes(sensor).
        command_type(CommandType::DIRECT_COMMAND_REPLY).
        send_command
    end

    # 指定したセンサーとそのモードにおける値を取得する
    # see:
    #   http://www.afrel.co.jp/archives/category/technical-information/tech-ev3-hardware
    def get_sensor(sensor, mode = 0)
      Commands::Input.new(@connection).
        sensor(sensor, mode).
        command_type(CommandType::DIRECT_COMMAND_REPLY).
        send_command.
        get_data
    end

    # 指定した速度で、指定したモーターを動かす
    def start(velocity, *motors)
      Commands::Output.new(@connection).
        command_type(CommandType::DIRECT_COMMAND_NO_REPLY).
        speed(velocity, *motors).
        start(*motors).
        send_command
    end

    # 指定したモーターの速度を設定する
    def speed(velocity, *motors)
      Commands::Output.new(@connection).
        command_type(CommandType::DIRECT_COMMAND_NO_REPLY).
        speed(velocity, *motors).
        send_command
    end

    # モーターを指定した速度で指定した角度だけ動かす
    #
    # degrees: フルスピードでモーターを動かす角度
    # precision: 終盤で減速しつつモーターを動かす角度
    def step_velocity(velocity, degrees, precision, *motors)
      Commands::Output.new(@connection).
        command_type(CommandType::DIRECT_COMMAND_NO_REPLY).
        step_velocity(velocity, degrees, precision, *motors).
        send_command
    end

    # 指定したモーターのタコメーターの値（回転数）をリセットする
    def reset(*motors)
      Commands::Output.new(@connection).
        command_type(CommandType::DIRECT_COMMAND_NO_REPLY).
        reset(*motors).send_command
    end

    # 指定したモーターの回転方向を正方向にする
    def run_forward(*motors)
     Commands::Output.new(@connection).
       command_type(CommandType::DIRECT_COMMAND_NO_REPLY).
       reverse_polarity(1, *motors).
       send_command
    end

    # 指定したモーターの回転方向を反転する
    def reverse_polarity(*motors)
      Commands::Output.new(@connection).
        command_type(CommandType::DIRECT_COMMAND_NO_REPLY).
        reverse_polarity(0, *motors).
        send_command
    end

    # 指定したモーターの動きを止める
    #
    # force_break: true だと即座にとまり、false だと慣性がつく
    def stop(force_break, *motors)
      Commands::Output.new(@connection).
        command_type(CommandType::DIRECT_COMMAND_NO_REPLY).
        stop(force_break, *motors).send_command
    end

    # LEDの色をcolorに設定する
    # 0 : LEDオフ
    # 1 : 緑
    # 2 : 赤
    # 3 : 橙
    # 4 : 緑点滅(パターン1)
    # 5 : 赤点滅(パターン1)
    # 6 : 橙点滅(パターン1)
    # 7 : 緑点滅(パターン2)
    # 8 : 赤点滅(パターン2)
    # 9 : 橙点滅(パターン2)
    def set_led(color)
      Commands::UiWrite.new(@connection).
        set_led.
        command_type(CommandType::DIRECT_COMMAND_NO_REPLY).
        send_command
    end

    # 音を鳴らす
    # volume: 音量(0-100)
    # freq: 周波数(250-10000)
    # duratinon: 長さ(ミリ秒単位、1000 = 1秒間)
    def play_tone(volume, freq, duration)
      Commands::Sound.new(@connection).
        set_tone(volume, freq, duration).
        command_type(CommandType::DIRECT_COMMAND_NO_REPLY).
        send_command
    end
    
    # 音を止める
    def stop_sound
      Commands::Sound.new(@connection).
        stop_sound.
        command_type(CommandType::DIRECT_COMMAND_NO_REPLY).
        send_command
    end
  end
end
