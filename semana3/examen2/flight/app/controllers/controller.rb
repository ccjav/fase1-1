class Controller
  def initialize(args)
    @view = View.new
    send(args[0])
  end

  def index
    @view.index
    while true
      @choice = STDIN.gets.chomp
      break if @choice == '1' || @choice == '2' || @choice == '3'
      @view.error
    end

    if @choice == "1"
      @view.reservations
      reservations
    elsif @choice == "2"
      @view.admin
      admin
    elsif @choice == "3"
      "Salir"
    end
  end

  def reservations
    while true
      @choice = STDIN.gets.chomp
      break if @choice == '1' || @choice == '2'
      @view.error
    end

    if @choice == "1"
      make_reservation
    elsif @choice == "2"
      "Salir"
    end
  end

  def make_reservation
    flight_query = []
    puts "From:"
    flight_query << STDIN.gets.chomp
    puts "To:"
    flight_query << STDIN.gets.chomp
    puts "Date:"
    flight_query << STDIN.gets.chomp
    puts "Passengers (1, 2, 3, 4...):"
    flight_query << STDIN.gets.chomp
    available_flights(flight_query)
  end

  def available_flights(flight_query)
    flight_query_array = Flight.where(to: flight_query[1], from: flight_query[0], date: flight_query[2])
    flight_options = []
    counter = 1
    flight_query_array.each do |flight|
      if flight_query[3].to_i <= flight["passengers"]
        @view.fligts(counter, flight)
        flight_options << flight["num_flight"]
        counter += 1
      end
    end
    counter -= 1
    if counter > 0
      choose_flight(flight_query, flight_options, counter)
    else
      puts "No hay vuelos disponibles."
      puts "Nueva búsqueda:"
      make_reservation
    end
  end

  def choose_flight(flight_query, flight_options, counter)
    puts "Selecciona tu vuelo:"
    while true
      flight_choice = STDIN.gets.chomp.to_i
      break if (flight_choice <= counter) && (flight_choice != 0)
      @view.error
    end
    present_flight = (Flight.where(num_flight: flight_options[flight_choice - 1]))[0]
    user_info(present_flight, flight_query)
  end

  def user_info(present_flight, flight_query)
    users_ids = []
    flight_query[3].to_i.times do |i|
      puts "Datos de persona " + "#{(i + 1)}" + ":"
      puts "Ingresa tu nombre:"
      name = STDIN.gets.chomp
      puts "Email:"
      email = STDIN.gets.chomp
      User.create(name: name, email: email, admin: false)
      present_user = User.where(name: name, email: email, admin: false)
      users_ids << present_user[0]["id"]
    end
    puts "¿Realizar reservación? SI / NO"
    while true
      @booking_choice = STDIN.gets.chomp
      break if @booking_choice == 'si' || @booking_choice == 'SI' || @booking_choice == 'NO' || @booking_choice == 'no'
      @view.error
    end
    if @booking_choice == 'si' || @booking_choice == 'SI'
      create_booking(present_flight, flight_query, users_ids)
      create_user_flight(present_flight, flight_query, users_ids)
    elsif @booking_choice == 'no' || @booking_choice == 'NO'
      index
    end
  end

  def create_booking(present_flight, flight_query, users_ids)
    total_cost = present_flight["cost"].to_i * flight_query[3].to_i
    book_num = "#{rand(1000..2000)}-#{rand(0..9)}"
    Booking.create(num_booking: book_num, flight_id: present_flight["id"], total: total_cost)
    present_booking = Booking.where(num_booking: book_num, flight_id: present_flight["id"], total: total_cost)
    flight_query[3].to_i.times do |i|
      UserBooking.create(id_bookings: present_booking[0]["id"], id_users: users_ids[i])
    end
  end

  def create_user_flight(present_flight, flight_query, users_ids)
    flight_query[3].to_i.times do |i|
      UserFlight.create(flight_id: present_flight["id"], user_id: users_ids[i])
    end
  end

  def admin
    while true
      choice = STDIN.gets.chomp
      break if User.exists?(name: choice , admin: true)
      @view.error
    end

    puts "Ingrese contraseña:"
    while true
      choice = STDIN.gets.chomp
      break if choice == "password"
      @view.error
    end

    @view.logged_admin
    logged_admin
  end

  def logged_admin
    while true
      @choice = STDIN.gets.chomp
      break if @choice == '1' || @choice == '2' || @choice == '3' || @choice == '4'
      @view.error
    end
    if @choice == '1'
      counter = 1
      all_flights = Flight.all
      all_flights.each do |flight|
        @view.fligts(counter, flight)
        counter += 1
      end
      @view.logged_admin
      logged_admin
    elsif @choice == '2'
      puts "Reservaciones:"
      counter = 1
      booked_flights = Booking.all
      booked_flights.each do |booking|
        @view.bookings(counter, booking)
        counter += 1
      end
      @view.logged_admin
      logged_admin
    elsif @choice == '3'
      add
    end
  end

  def add
    @flight_info = []
    puts "Crear vuelo."
    puts "Número de vuelo:"
    @flight_info << STDIN.gets.chomp
    puts "Fecha del vuelo:"
    @flight_info << STDIN.gets.chomp
    puts "Hora de salida:"
    @flight_info << STDIN.gets.chomp
    puts "Origen:"
    @flight_info << STDIN.gets.chomp
    puts "Destino:"
    @flight_info << STDIN.gets.chomp
    puts "Duración:"
    @flight_info << STDIN.gets.chomp
    puts "Precio:"
    @flight_info << STDIN.gets.chomp
    puts "Número de pasajeros:"
    @flight_info << STDIN.gets.chomp
    Flight.create(num_flight: @flight_info[0], date: @flight_info[1], depart: @flight_info[2], from: @flight_info[3], to: @flight_info[4], duration: @flight_info[5], cost: @flight_info[6], passengers: @flight_info[7])
  end


  def delete
  end

  def complete
  end
end
