require 'csv'

class QuestionsParser
  def to_array
    @array = CSV.read("preguntas.csv")
  end
end

class GameLauncher < QuestionsParser
  def start_game
    p "hola, vamos a jugar maratón :D"
    to_array
    Questioneer.new.ask_questions
  end
end

class Questioneer < QuestionsParser
  def ask_questions
    contador = 0
    while contador < to_array.length
      p "Pregunta: #{@array[contador].join(" ")}"
      contador += 1
      respuesta = gets.chomp
      if respuesta == @array[contador].join(" ")
        p "Respuesta: #{respuesta}"
        p "bien :D"
        AnswerCounter.count_correct(1)
      else
        "Respuesta: #{respuesta}"
        p "mal :("
        AnswerCounter.count_incorrect(1)
      end
      contador += 2
    end
    AnswerCounter.results
  end
end

class AnswerCounter
  @buenas = 0
  @malas = 0
  def self.count_correct(number)
    @buenas += number
  end

  def self.count_incorrect(number)
    @malas += number
  end

  def self.results
    puts "\e[#{5}m#{"Tuviste #{@buenas} respuestas correctas"}\e[0m"

    puts "\e[#{5}m#{"Tuviste #{@malas} respuestas incorrectas"}\e[0m"
  end
end

game1 = GameLauncher.new
game1.start_game
