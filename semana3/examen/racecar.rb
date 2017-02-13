LAP_DISTANCE = 100.0

class RaceCar
	attr_reader :name, :car_level
	def initialize(name)
	    @name = name
	    @laptimes = []
	    5.times { @laptimes <<  LAP_DISTANCE / rand(7.0..18.0)}
	    @avg_speed = (@laptimes.inject(:+) / 5).round(2)
	    @car_level = car_level
	  end

	def car_level
		if @avg_speed < 7.0
			@level = "Principiante"
		elsif @avg_speed < 8.0
			@level = "Normal"
		elsif @avg_speed < 9.0
			@level = "Medio"
		else
			@level = "Avanzado"
		end
	end
end


#Team class
class Team
	def initialize(team)
		@team = team
    @@team = @team
	end

	def add_car(car)
    @team << car
	end

  def team_size
    @team.length
  end

	def average_speed_of_team
		(@team.map { |x| x.instance_variable_get(:@avg_speed) }.inject(:+) / @team.length).round(2)
	end

  def self.team
    @@team
  end
end

def search(name, team)
  names = Team.team.map { |x| x.instance_variable_get(:@name) }
  if names.include?(name)
    "#{name} is a racer"
  end
end

def table
  # names = Team.car_level.map { |x| x.instance_variable_get(:@level) }
  # RaceCar.map { |x| x }#.car_level#.instance_variable_get(:@level)


end

@name = ["Force", "Power", "Passwater", "Banjo", "Duck"].sample

car1 = RaceCar.new("Force")
car2 = RaceCar.new("Power")
car3 = RaceCar.new("Passwater")
car4 = RaceCar.new("Banjo")
car5 = RaceCar.new("Duck")
car6 = RaceCar.new("Thunder")
# p car1.car_level
# #tests
# p "car1: #{car1.average_speed} m/s"
# #ej. car1: 9.5 m/s
# p "car2: #{car2.average_speed} m/s"
# #ej. car2: 12.01 m/s
# p "car3: #{car3.average_speed} m/s"
# #ej. car3: 10.65 m/s
# p "car4: #{car4.average_speed} m/s"
# #ej. car4: 11.0 m/s
# p "car5: #{car5.average_speed} m/s"
# #ej. car5: 10.15 m/s
# p "car6: #{car6.average_speed} m/s"
# #ej. car6: 15.51 m/s

# #create a team of cars
team1 = [car1, car2, car3, car4, car5]
team_one = Team.new(team1)
team_one.add_car(car6)

# #test para buscar race car en equipo team_one
# p search("Power", team_one) == "Power is a racer"
p table
# #calculate average speed of team
# p team_one.average_speed_of_team
# #ej. 10.66

# #método para mostrar nombre y nivel del race car
# ...