class Heap
  def initialize
    # the math is simpler if we don't ignore the 0th place
    @nodes = [nil]
  end

  def length
    nodes.length - 1
  end

  def add(int)
    # validate
    nodes.push(int)
    sift_up_last_value
  end

  def pop
    return nil if nodes.length == 0
    swap(1, nodes.length - 1)

    max_value = nodes.pop

    sift_down_root_value if length > 0

    max_value
  end

  def replace(int)
    max_value = nodes[1]
    nodes[1] = int
    sift_down_root_value

    max_value
  end

  private

  def sift_up_last_value
    current_index = nodes.length - 1

    while current_index > 1
      current_value = nodes[current_index]
      parent = parent(current_index)

      if current_value > parent[:value]
        swap(current_index, parent[:index])
        current_index = parent[:index]
      else
        break
      end
    end
  end

  def sift_down_root_value
    current_index = 1

    loop do
      current_value = nodes[current_index]
      largest_child = children(current_index).max_by { |child| child[:value] }

      if largest_child[:value] > current_value
        swap(current_index, largest_child[:index])
        current_index = largest_child[:index]
      else
        break
      end
    end
  end

  def parent(index)
    parent_index = index / 2
    parent_value = nodes[parent_index]

    { index: parent_index, value: parent_value }
  end

  def children(index)
    child_index_1 = index * 2
    child_index_2 = index * 2 + 1

    # The `to_i` is a trick to handle the end of the heap.
    # Going past the end returns a value of `nil`.
    # `nil.to_i` is 0.
    # If we assume all input is greater than 0,
    # then we'll never try to swap past the end of the heap.
    child_value_1 = nodes[child_index_1].to_i
    child_value_2 = nodes[child_index_2].to_i
    
    [
      { index: child_index_1, value: child_value_1 },
      { index: child_index_2, value: child_value_2 },
    ]
  end

  def swap(index_1, index_2)
    original_index_1_value = nodes[index_1]
    nodes[index_1] = nodes[index_2]
    nodes[index_2] = original_index_1_value
  end

  attr_reader :nodes
end