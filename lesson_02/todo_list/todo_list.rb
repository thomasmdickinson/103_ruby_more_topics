require_relative 'todo'
require 'pry'

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
    str = "---- #{@title} ----"
    @todos.each do |item|
      str += "\n"
      str += item.to_s
    end
    str
  end

  def each
    @todos.each { |item| yield item }
    self
  end

  def select
    selected_items = TodoList.new(title)
    @todos.each do |item|
      selected_items << item if yield(item)
    end
    selected_items
  end

  def find_by_title(str)
    select { |item| item.title == str }.first
  end

  def all_done
    select { |item| item.done? }
  end

  def done?
    all_done.size == size
  end

  def all_not_done
    select { |item| !item.done? }
  end

  def mark_done(str)
    find_by_title(str).done!
  end

  def mark_all_done
    each { |item| item.done! }
  end
  alias_method :done!, :mark_all_done

  def mark_all_undone
    each { |item| item.undone! }
  end

  def to_a
    @todos
  end

  def shift
    to_a.shift
  end

  def pop
    to_a.pop
  end

  def ==(other)
    todos == other.todos
  end
end


require_relative 'todo_list'

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!
