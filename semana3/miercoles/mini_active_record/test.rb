require_relative 'app'

def assert(truthy)
  raise "Tests failed" unless truthy
end

# chef = Chef.find(2)
# p chef.new_record?
# chef = Chef.create(first_name: "Eduardo", last_name: "Fernández", email:"eduardo@gmail.com", phone:"930-028-2908 x7555", birthday:Time.now)
# p chef = Chef.where("first_name = 'Demarco'")
# p chef
# chef.add_meals(["Veal Parmigiana"])
# Este es un ejemplo de test ya que los nombres de los chefs son aleatorios, este test muy probablemente fallará
# assert chef[:first_name] == 'Eduardo'
# assert chef[:last_name] == 'Fernández'

# meal = Meal.create(name: "Smoked Salmon", chef_id: "24", created_at: Time.now, updated_at: Time.now)
# p meal = Meal.where("name = 'Veal Parmigiana'")
# meal = Meal.find(91)
# p meal.new_record?
# assert meal[:name] == 'Veal Parmigiana'
# chef = Chef.find(2)
# p chef
# p Chef.all
# meal = Meal.new

chef = Chef.new(id: 34, first_name: "Maria", last_name: "Fernández", email:"eduardo@gmail.com", phone:"930-028-2908 x7555", birthday:Time.now)
chef.update!

# meal = Meal.new(name: "Smoked Salmon", chef_id: "24", created_at: Time.now, updated_at: Time.now)
# meal.update!
# p meal
puts "finished"
