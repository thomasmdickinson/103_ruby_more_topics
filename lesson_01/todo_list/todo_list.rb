require 'pry'
require_relative 'todo'

class TodoList
  attr_accessor :title, :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def <<(item)
    raise TypeError, 'Can only add Todo objects' unless item.class == Todo
    @todos << item if item.class == Todo
  end
  alias_method :add, :<<

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def index_error_check(num)
    raise IndexError if num >= @todos.size
  end

  def item_at(num)
    index_error_check(num)
    @todos[num]
  end

  def mark_done_at(num)
    index_error_check(num)
    @todos[num].done!
  end

  def mark_undone_at(num)
    index_error_check(num)
    @todos[num].undone!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(num)
    index_error_check(num)
    @todos.delete_at(num)
  end

  def to_s
    puts "---- #{@title} ----"
    @todos.each { |item| puts item }
  end
end
