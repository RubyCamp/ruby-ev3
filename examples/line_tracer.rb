require 'dxruby'
require_relative '../lib/ev3'

LEFT_MOTOR = "D"
RIGHT_MOTOR = "A"
COLOR_SENSOR = "3"
PORT = "COM3"
MOTOR_SPEED = 50

def on_road?(brick)
  6 != brick.get_sensor(COLOR_SENSOR, 2)
end

begin
  puts "starting..."
  font = Font.new(32)
  brick = EV3::Brick.new(EV3::Connections::Bluetooth.new(PORT))
  brick.connect
  puts "connected..."
  motors = [LEFT_MOTOR, RIGHT_MOTOR]
  # モーターの回転方向を初期化
  brick.reset(*motors)

  Window.loop do
    break if Input.keyDown?( K_SPACE )
    if on_road?(brick)
      Window.draw_font(100, 200, "on road", font)
      # 前進する
      brick.start(MOTOR_SPEED, *motors)
      sleep 0.2
      brick.stop(false, *motors)
    else
      Window.draw_font(100, 200, "off road", font)
      # 少し戻る
      brick.reverse_polarity(*motors)
      brick.start(MOTOR_SPEED, *motors)
      sleep 0.1
      brick.stop(*motors)
      # 少しだけ左に曲がる（右タイヤ前進、左タイア後退）
      brick.reverse_polarity(RIGHT_MOTOR)
      brick.start(MOTOR_SPEED, *motors)
      sleep 0.1
      brick.stop(false, *motors)
      brick.run_forward(*motors)
    end
  end
rescue
  p $!
# 終了処理は必ず実行する
ensure
  puts "closing..."
  brick.stop(false, *motors)
  brick.clear_all
  brick.disconnect
  puts "finished..."
end


