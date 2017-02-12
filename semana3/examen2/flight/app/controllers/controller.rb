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
        @view.available_flights(counter, flight)
        flight_options << flight["num_flight"]
        counter += 1
      end
    end
    p flight_options
    puts "Selecciona tu vuelo:"

    user_info(flight_query, flight_options, counter)
  end

  def user_info(flight_query, flight_options, counter)
    while true
      flight_choice = STDIN.gets.chomp
      break if (flight_choice.to_i.is_a? Integer) && (flight_choice.to_i <= counter - 1) && (flight_choice.to_i != 0)
      @view.error
    end
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
    puts "Realizar reservación: SI / NO"
    while true
      @booking_choice = STDIN.gets.chomp
      break if @booking_choice == 'si' || @booking_choice == 'SI' || @booking_choice == 'NO' || @booking_choice == 'no'
      @view.error
    end
    if @booking_choice == 'si' || @booking_choice == 'SI'
      create_booking(flight_options, flight_choice, flight_query, users_ids)
      create_user_flight(flight_options, flight_choice, flight_query, users_ids)
    elsif @booking_choice == 'no' || @booking_choice == 'NO'
      index
    end
  end

  def create_booking(flight_options, flight_choice, flight_query, users_ids)
    present_flight = Flight.where(num_flight: flight_options[flight_choice.to_i - 1])
    total_cost = present_flight[0]["cost"].to_i * flight_query[3].to_i
    book_num = "#{rand(1000..2000)}-#{rand(0..9)}"
    Booking.create(num_booking: book_num, flight_id: present_flight[0]["id"], total: total_cost)
    present_booking = Booking.where(num_booking: book_num, flight_id: present_flight[0]["id"], total: total_cost)
    flight_query[3].to_i.times do |i|
      UserBooking.create(id_bookings: present_booking[0]["id"], id_users: users_ids[i])
    end
  end

  def create_user_flight(flight_options, flight_choice, flight_query, users_ids)
    present_flight = Flight.where(num_flight: flight_options[flight_choice.to_i - 1])
    flight_query[3].to_i.times do |i|
      UserFlight.create(flight_id: present_flight[0]["id"], user_id: users_ids[i])
    end
  end

  def admin
    @choice = STDIN.gets.chomp
    puts "Ingrese contraseña:"
    @choice = STDIN.gets.chomp
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
      p Flight.all
    elsif @choice == '2'
      p Booking.all
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
