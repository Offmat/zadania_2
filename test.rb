# require "csv"
require "pry"
#
# CSV.foreach("products.csv", converters: :float, headers: true, return_headers: true) do |r|
#   puts r
#   puts r.inspect
#   puts r.class
#   puts r.header_row?
#   # binding.pry
# end


# puts "%020s" % "ble"


class Cat

  def meow
    puts "Meow"
    puts "2"
  end

end

binding.pry
Cat.new.meow
