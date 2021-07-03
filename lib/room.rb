# class Room < ActiveRecord::Base
# end

attr_accessor :title, :date_create, :price, :url

def self.create_from_hash(hash)
    new_from_hash(hash).save
end

def self.new_from_hash(hash)
    room = self.new
    room.title = hash[:title]
    room.date_created = hash[:date_created]
    room.price = hash[:price]
    room.url = hash[:url]
    room  
end

def self.new_from_hash(hash)
    room = self.new
    room.title = hash[:title]
    room.date_created = hash[:date.created]
    room.price = hash[:price]
    room.url = hash[:url]

    room
end

def self.new_from_db(row)
    self.new.tap do |room| #just returns the instance
        room.id = row[0]
        room.title = row[1]
        room.date_created = row[2]
        room.price = row[3]
        room.url = row[4]
    end
end

def self.by_price(order = "ASC")
    case order
    when "ASC"
        self.all.sort by {|r| r.price}
    when "DESC"
        self.all.sort by {|r| r.price}.reverse
    end
end


def self.all
    sql = <<-SQL
        SELECT * FROM rooms;
    SQL

    rows = DB[:conn].execute(sql)
    rows.collect do |row|
        self.new_from_db(row)
    end
end

def insert
    sql = <<-SQL
        INSERT INTO rooms (title, date_created, price, url) VALUES (?, ?, ?, ? )
    SQL

    DB[:conn].execute(sql, self.title, self.date_created, self.price, self.url)
end

def self.create_table
    sql = <<-SQL
        CREATE TABLE IF NOT EXISTS rooms (
            id INTEGER PRIMARY KEY,
            title TEXT,
            date_created DATETIME,
            price TEXT,
            url TEXT
        )
    SQL

    DB[:conn].execute(sql)
end
