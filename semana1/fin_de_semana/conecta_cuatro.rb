class ConectFour
	def initialize#(args)
		@board = (('(' + " " + ')') * 48).scan(/(.{21})(?=.)/).join("\n")
		@white = "\u25cf"
		@black = "\u25cb"
		# @lastturn = @black
	end

	def print_board
		puts (('(' + white + ')') * 48).scan(/(.{21})(?=.)/).join("\n")
	end

	def drop_chip!(player)
		puts "columna:"
		column = gets.chomp.to_i
		if column == 1 then column = 1 else column = (column * 2) + (column - 2) end
		while @board[column] == " "
			if @board[column + 22] == " "
				column += 22
			else
				@board[column] = player
				@lastturn = player
				puts @board
				last_turn
			end
		end
	end

	def last_turn
		if @lastturn == @white
			drop_chip!(@black)
		elsif @lastturn == @black
			drop_chip!(@white)
		else
			drop_chip!(@white)
		end
	end

	def finished?

	end

	def winner

	end
end

prueba = ConectFour.new

puts prueba.last_turn

