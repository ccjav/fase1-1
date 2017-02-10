LAP_DISTANCE = 100.0
#RaceCar class
class RaceCar
	def initialize
		@laptimes = []
		5.times { @laptimes <<  LAP_DISTANCE / rand(7.0..18.0)}
		@avg_speed = (@laptimes.inject(:+) / 5).round(2)
		# @hola
	end

	def avg_speed
		@@avg_speed = @avg_speed
	end

	def car_level
		if average_speed < 7.0
			"Principiante"
		elsif average_speed < 8.0
			"Normal"
		elsif average_speed < 9.0
			"Medio"
		else
			"Avanzado"
		end
	end
end
# hola = RaceCar.new
# hola
# p hola.average_speed
# p hola.car_level

#Team class
class Team
	def initialize(team)
		@team = team
	end

	def add_car(car)
		Team.new(car)
	end

	def average_speed_of_team
		@team.each {|x| p x[1]}
	end
  #método para agregar nuevo race car


  #método para calcular promedio de velocidad del equipo


end

# #método para buscar race car
# ...

# #método para generar la tabla
# ...

# #método para mostrar nombre y nivel del race car
# ...


# #instancias de RaceCar
car1 = RaceCar.new
car2 = RaceCar.new
car3 = RaceCar.new
car4 = RaceCar.new
car5 = RaceCar.new
car6 = RaceCar.new

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
p team_one.average_speed_of_team
# #test para buscar race car en equipo team_one
# p search("Power", team_one) == "Power is a racer"

# #calculate average speed of team
# p team_one.average_speed_of_team
# #ej. 10.66

# #método para mostrar nombre y nivel del race car
# ...