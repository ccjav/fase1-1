require 'sqlite3'

class Chef
  def initialize(first_name, last_name, birthday, email, phone)
    @first_name = first_name
    @last_name = last_name
    @birthday = birthday
    @email = email
    @phone = phone
    # @created_at = created_at
    # @updated_at = updated_at

  end

  def self.create_table
    Chef.db.execute(
      <<-SQL
        CREATE TABLE chefs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          birthday DATE NOT NULL,
          email VARCHAR(64) NOT NULL,
          phone VARCHAR(64) NOT NULL
        );
      SQL
    )
  end

  def self.seed
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone)
        VALUES
          (@first_name, @last_name, @birthday, @email, @phone);
      SQL
    )
  end

  def self.all
    Chef.db.execute(
      <<-SQL
        SELECT * FROM chefs
      SQL
    )
  end

  def self.where(key, value)
    # p key
    # p value
    Chef.db.execute(
      <<-SQL
        SELECT * FROM chefs WHERE "key" = "value"
      SQL
    )
  end

  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end

end

# Chef.new('Juan', 'Lando', '1990-05-22', 'jualando@hotmail.com', '48232359671')
# p Chef.all
# Chef.seed
# p Chef.where("id", 2)
