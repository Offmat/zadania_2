# Załączony plik products.csv (format CSV) zawiera nazwy produktów, ich ceny oraz
# wagę. Napisz program, który:
# • wczyta produkty oraz ich ceny z pliku products.csv
# • umożliwi wyszukanie produktu po jego nazwie
# $ ruby products.rb -f apple
# apple 1.25zł
# • umożliwi wyświetlenie produktów tańszych/droższych od podanej w argumencie
# ceny
# $ ruby products.rb -gt 2.25
# orange 2.50zł
# carrot 2.30zł
# juice 5.50zł
# chocolate 7.20zł
# $ ruby products.rb -lt 2.25
# sunflower seeds 0.99zł
# oil 2.22zł
# cookies 2.20zł
# flour 1.99zł
# sugar 2.00zł
# • umożliwi konwersję cen produktów do innej waluty po zadanym w argumencie
# wywołania kursie, dane po konwersji zapisze do pliku o zadanej w argumencie
# wywołania nazwie$ ruby products.rb -c 3.45 EUR productsEUR.csv
# Przydatne linki:
# • CSV - klasa dostarczająca interfejs do obsługi plików .csv (wymaga dodania require
# "csv" )


require "csv"
require "pry"

class Warehouse
  def initialize
    @products = []
  end

  def print(product)
    puts product[0] + " " + product[1].to_s
  end

  def add(object)
    @products.push(object)
  end

  def find(name)
    @products.each do |product|
      print(product) if product[0] == name
    end
  end

  def greater(price)
    @products.each do |product|
      print(product) if product[1] > price
    end
  end

  def lesser(price)
    @products.each do |product|
      print(product) if product[1] < price
    end
  end

  def convert(rate, file_name)
    @products.each do |product|
      product[1] = (product[1] / rate).round(2)
    end
    CSV.open(file_name, "w") do |csv|
      @products.each do |product|
        csv << product
      end
    end
  end

end



def menu(collection)
  collection.find(ARGV[1]) if ARGV[0] == "-f"
  collection.greater(ARGV[1].to_f) if ARGV[0] == "-gt"
  collection.lesser(ARGV[1].to_f) if ARGV[0] == "-lt"
  collection.convert(ARGV[1].to_f, ARGV[3]) if ARGV[0] == "-c"
end



warehouse = Warehouse.new
CSV.foreach("products.csv", converters: :float, headers: true,) do |r|
  warehouse.add(r)
end
# binding.pry
menu(warehouse)