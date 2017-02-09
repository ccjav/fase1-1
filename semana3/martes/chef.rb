require 'sqlite3'

class Chef
  def initialize(first_name, last_name, birthday, email, phone)
    @@first_name = first_name
    @@last_name = last_name
    @@birthday = birthday
    @@email = email
    @@phone = phone
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
          phone VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )
  end

  def self.seed
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ('Ferran', 'Adriá', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now'));
      SQL
    )
  end

  def save
    Chef.db.execute("insert into chefs (first_name, last_name, birthday, email, phone, created_at, updated_at) values (?, ?, ?, ?, ?, DATETIME('now'), DATETIME('now'))", @@first_name, @@last_name, @@birthday, @@email, @@phone)
  end

  def self.where(key, value)
    Chef.db.execute("SELECT * FROM chefs WHERE #{key} = '#{value}'")
  end

  def self.delete(key, value)
    Chef.db.execute("DELETE FROM chefs WHERE #{key} = '#{value}'")
  end

  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end

end