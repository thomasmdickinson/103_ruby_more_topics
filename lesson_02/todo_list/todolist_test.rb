require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require 'simplecov'
SimpleCov.start

require_relative 'todo_list'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(@list.size, 3)
  end

  def test_first
    assert_same(@list.first, @todo1)
  end

  def test_last
    assert_same(@list.last, @todo3)
  end

  def test_shift
    item = @list.shift
    assert_same(item, @todo1)
    assert_equal(@list.to_a, [@todo2, @todo3])
  end

  def test_pop
    item = @list.pop
    assert_same(item, @todo3)
    assert_equal(@list.to_a, [@todo1, @todo2])
  end

  def test_done?
    assert_equal(false, @list.done?)
    @list.mark_all_done
    assert_equal(true, @list.done?)
  end

  def test_type_error
    assert_raises(TypeError) { @list << (2) }
  end

  def test_add_alias
    new_item = Todo.new("write a test")
    list1 = @list.clone
    list2 = @list.clone
    list1 << new_item
    list2.add(new_item)
    assert_equal(list1, list2)
  end

  def test_item_at
    assert_same(@list.item_at(1), @todo2)
    assert_raises(IndexError) { @list.item_at(10) }
  end

  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(10) }
    @list.mark_done_at(1)
    assert_equal(false, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_done_at(10) }
    @todo1.done!
    @todo2.done!
    @todo3.done!
    @list.mark_undone_at(1)
    assert_equal(true, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_done!
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.mark_done_at(10) }
    @list.remove_at(1)
    assert_equal(@list.to_a, [@todo1, @todo3])
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
    assert_equal(output, @list.to_s)
  end

  def test_to_s_one_done
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT
    @list.mark_done_at(1)
    assert_equal(output, @list.to_s)
  end

  def test_to_s_all_done
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_each_iterates
    arr = []
    @list.each { |item| arr << item }
    assert_equal(arr, [@todo1, @todo2, @todo3])
  end

  def test_each_returns
    assert_same(@list, @list.each{ |item| item.title.upcase! })
  end

  def test_select
    @todo2.done!
    assert_equal(@list.select{ |item| !item.done?}.to_a, [@todo1, @todo3])
  end



end
