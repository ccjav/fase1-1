class CreditCard
  attr_accessor :name, :number, :expiration, :cvc, :status

  def initialize(name, number, expiration, cvc, status)
    @name = name
    @number = number
    @expiration = expiration
    @cvc = cvc
    @status = status
  end
end

class Amex < CreditCard
  
end

class Scotiabank < CreditCard
  
end

class Bancomer < CreditCard
  
end

class Serfin < CreditCard
  
end

class Bancoppel < CreditCard
  
end

amex = Amex.new("Amex", 2345673444, "12/15", 2345, [234, 567, 456, 567, 344])
scotiabank = Scotiabank.new("Scotiabank", 2345673744, "12/16", 2845, [234, 345, 456, 567, 344])
bancomer = Bancomer.new("Bancomer", 2345673444, "12/15", 2645, [234, 345, 456, 567, 344])
serfin = Serfin.new("Serfin", 2345473454, "12/20", 1345, [234, 345, 456, 567, 344])
bancoppel = Bancoppel.new("Bancoppel", 2345373464, "12/18", 2445, [567, 345, 456, 567, 344])

cards = [amex, scotiabank, bancomer, serfin, bancoppel]

cards.each do |card|
   puts "#{card.name} responds to:"
   puts "\tName: #{card.respond_to?(:name) == true}"
   puts "\tNumber: #{card.respond_to?(:number) == true}"
   puts "\tExpiration: #{card.respond_to?(:expiration) == true}"
   puts "\tcvc: #{card.respond_to?(:cvc) == true}"
   puts "\tGet status: #{card.respond_to?(:status) == true}"
   puts "\tSet status: #{card.respond_to?(:status=) == true}"
   puts "\n\n"
end

def show_table(cards)
  header = "|" + "name".center(14) + "|" + "number".center(13) + "|" + "expiration".center(12) + "|" + "cvc".center(8) + "|" + "status".center(28) + "|"
  puts header
  puts "-" * header.length
  cards.each do |card|
     puts "|  " + "#{card.name}".ljust(12) + "|" + "#{card.number}".center(13) + "|" + "#{card.expiration}".center(12) + "|" + "#{card.cvc}".center(8) + "|" + "#{card.status}".center(28) + "|"
  end
end

show_table(cards)