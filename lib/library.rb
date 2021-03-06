require 'yaml'
require 'date'

class Library
  attr_accessor :books
  def initialize
    @books = YAML.load_file('./lib/data.yml')
  end

  def search(book)
    @books.select{ |obj| obj[:item][:title].include? book }
  end

  def what_is_available?
    @books.select{ |obj| obj[:available] == true }.map{|obj| obj[:item]}
  end

  def borrow(book, individual)
    # case
    # when search(book).map{|obj| obj[:available] != true}
    #   raise 'Book is not availble right now' + date=
    # else
      search(book).map{|obj| obj[:available] = false}
      search(book).map{|obj| obj[:current_possessor] = (individual)}
      search(book).map{|obj| obj[:return_date] = Date.today.next_month(1).strftime('%d/%m/%y')}
      File.open('./lib/data.yml', 'w') { |f| f.write @books.to_yaml }
    end
  end

  # def return(book)
  #   search(book).map{|obj| obj[:available] = true}
# end
