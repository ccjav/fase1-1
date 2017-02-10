class Athlete
  attr_accessor :total_time, :speed_record, :total_distance
  def initialize(distance=0, time=0)
    @distance = distance
    @time = time
    @total_time = @time
    @total_distance = @distance
  end

  def speed
    @speed = (@distance / @time.to_f).round(2)
    if @speed.to_f.nan? then @speed = 0 end
  end

  def new_workout(distance=0, time=0)
    @distance = distance
    @time = time
    @total_time += @time
    @total_distance += @distance
  end

  def total_time
    "#{self.class}'s total time is #{@total_time}"
  end

  def total_distance
    "#{self.class}'s total distance is #{@total_distance}"
  end

  def speed_record
    "#{self.class}'s average speed is #{(@total_distance / @total_time.to_f).round(2)}"
  end
end

class Runner < Athlete
  def run
    speed
    "Ran #{@distance} meters, time: #{@time} seconds, speed: #{@speed} m/s"
  end
end

class Swimmer < Athlete
  def swim
    speed
    "Swam #{@distance} meters, time: #{@time} seconds, speed: #{@speed} m/s"
  end
end

class Cyclist < Athlete
  def ride_bike
    speed
    "Rode #{@distance} meters, time: #{@time} seconds, speed: #{@speed} m/s"
  end
end

#tests

#instancias de atletas con distancia en metros
runner = Runner.new()
swimmer = Swimmer.new(50, 10)
cyclist = Cyclist.new(70, 27)

athletes = [runner, swimmer, cyclist]

athletes.each do |athlete|
  #¿qué tipo de atleta es?
  puts "#{athlete.class} responds to:"
  puts "\tAthlete speed: #{athlete.respond_to?(:speed) == true}"
  puts "\tGet Athlete time: #{athlete.respond_to?(:total_time) == true}"
  puts "\tSet Athlete time: #{athlete.respond_to?(:total_time=) == true}"
  puts "\tSpeed record: #{athlete.respond_to?(:speed_record) == true}"
  puts "\tGet Distance: #{athlete.respond_to?(:total_distance) == true}"
  puts "\tSet Distance: #{athlete.respond_to?(:total_distance=) == true}"
  puts "\trun method: #{athlete.respond_to?(:run) == true}" if athlete == runner
  puts "\tswim method: #{athlete.respond_to?(:swim) == true}" if athlete == swimmer
  puts "\tride_bike method: #{athlete.respond_to?(:ride_bike) == true}" if athlete == cyclist
  puts "\n\n"
end

#test for runner

#test para runner con distancia = 0
# p runner.speed
p runner.run == "Ran 0 meters, time: 0 seconds, speed: 0 m/s"
#test para runner al hacer ejercicio, incrementa distancia = 20 metros y tiempo = 7 segundos
runner.new_workout(20, 7)
# p runner.speed
#test para runner con distancia = 20 metros y tiempo = 7 segundos
p runner.run == "Ran 20 meters, time: 7 seconds, speed: 2.86 m/s"
runner.new_workout(20, 7)
# p runner.total_time
# p runner.total_distance
#test para swimmer con distancia = 50
p swimmer.swim == "Swam 50 meters, time: 10 seconds, speed: 5.0 m/s"

swimmer.new_workout(20, 7)
swimmer.new_workout(20, 7)
swimmer.new_workout(20, 7)

swimmer.new_workout(20, 7)
p swimmer.swim
p runner.run
p swimmer.total_time
p runner.total_time
p swimmer.total_distance
p runner.total_distance
p cyclist.total_distance
p swimmer.speed_record
p runner.speed_record
p cyclist.speed_record