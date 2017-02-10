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
    @flight_query = []
    puts "From:"
    @flight_query << STDIN.gets.chomp
    puts "To:"
    @flight_query << STDIN.gets.chomp
    puts "Date:"
    @flight_query << STDIN.gets.chomp
    puts "Passengers (1, 2, 3, 4...):"
    @flight_query << STDIN.gets.chomp
    available_flights(@flight_query)
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

  def available_flights(query)
    query_array = Flight.where(to: query[1], from: query[0], date: query[2])
    selected_flight = []
    counter = 1
    query_array.each do |flight|
      if query[3].to_i <= flight["passengers"]
        @view.available_flights(counter, flight)
        selected_flight << flight["num_flight"]
        counter += 1
      end
    end
    puts "Selecciona tu vuelo:"

    user_info(query, selected_flight)
  end

  def user_info(query, selected_flight)
    flight_choice = STDIN.gets.chomp
    # p Flight.where(num_flight: selected_flight[flight_choice.to_i - 1])
    users_ids = []
    query[3].to_i.times do |i|
      puts "Datos de persona " + "#{(i + 1)}" + ":"
      puts "Ingresa tu nombre:"
      name = STDIN.gets.chomp
      puts "Email:"
      email = STDIN.gets.chomp
      User.create(name: name, email: email, admin: false)
      present_user = User.where(name: name, email: email, admin: false)
      users_ids << present_user[0]["id"]
      present_flight = Flight.where(num_flight: selected_flight[flight_choice.to_i - 1])
    end
    puts "Realizar reservación: SI / NO"
    booking_choice = STDIN.gets.chomp
    create_booking
  end

  def create_booking
    present_flight = Flight.where(num_flight: selected_flight[flight_choice.to_i - 1])
    total_cost = present_flight[0]["cost"].to_i * query[3].to_i
    book_num = "#{rand(1000..2000)}-#{rand(0..9)}"
    Booking.create(num_booking: book_num, flight_id: present_flight[0]["id"], total: total_cost)
    present_booking = Booking.where(num_booking: book_num, flight_id: present_flight[0]["id"], total: total_cost)

    query[3].to_i.times do |i|
      UserBooking.create(id_bookings: present_booking[0]["id"], id_users: users_ids[i])
    end 
  end

  def delete
  end

  def complete
  end
end
