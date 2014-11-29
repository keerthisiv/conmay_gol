def me
  'alive'
end

def num_neighbours_alive
  2
end


class Cell
 
  def state=(state)
    @state = state
  end

  def state 
    @state || "empty"
  end

  def add_neighbours(*cells)
    @neighbours ||= []
    @neighbours += cells
  end

  def neighbours
    @neighbours
  end

  def num_neighbours_alive
    @neighbours.select { |cell| cell.state == "alive" }.count  
  end
end
