class View
	# Recuerda que la única responsabilidad de la vista es desplegar data al usuario
  # Los siguientes métodos son sólo un ejemplo:

	def index
    puts "Bienvenido a Vuelos Codea"
    puts "1) Reservaciones"
    puts "2) Administrador"
    puts "3) Salir"
    puts "Selecciona opción:"
	end

  def reservations
    puts "¡¡¡Bienvenido!!!"
    puts "1) Encuentra tu boleto de avión"
    puts "2) Salir"
    puts "Selecciona una opción:"
  end

  def admin
    puts "Bienvenido Administrador"
    puts "Ingrese usuario:"
  end

  def flight_search
    puts "¡¡¡Bienvenido!!!"
    puts "1) Encuentra tu boleto de avión"
    puts "2) Salir"
    puts "Selecciona una opción:"
  end

  def logged_admin
    puts "Bienvenido Administrador"
    puts "1) Muestra todos los vuelos"
    puts "2) Muestra todas las reservaciones"
    puts "3) Crea un nuevo vuelo"
    puts "4) Salir"
  end

  def flights(counter, flight)
    puts "#{counter}) " + "No Vuelo: " + flight["num_flight"].to_s
    puts "Date: " + flight["date"].to_s + ", Depart: " + flight["depart"].to_s + "UTC From: " + flight["from"].to_s
    puts "To: " + flight["to"].to_s + ", Duration: " + flight["duration"].to_s + ", Precio:" + flight["cost"].to_s + ", Lugares: " + flight["passengers"].to_s
    puts "-" * 35
  end

  def bookings(counter, booking)
    puts "#{counter}) " + "Número de reservación: " + "#{booking["num_booking"]}"
    puts "Número de vuelo: " + "#{booking["flight_id"]}"
    puts "Precio total: " + "#{booking["total"]}"
  end

  def create
  end

  def delete
  end

  def update
  end

	def error
    puts "Datos inválidos. Intenta de nuevo:"
	end
end
