require './lib/conmay.rb'

max=8
cells = {}
(0..max).each do |idx|
  cells[idx] = Cell.new
end

(0..max).each do |idx|
  me = cells[idx]
  (-4..4).each do |i| 
    neighbour_idx = idx+i
    next if cells[neighbour_idx].nil?
    next if idx == neighbour_idx
    me.add_neighbours(cells[neighbour_idx]) 
  end
end

cells.each do |idx,cell|
  next if idx == 3
  cell.state = 'alive'
end

def output_all cells
  cells.each do |idx,cell|
    case cell.state
    when "empty"
      char = "."
    when "alive"
      char = "v"
    when "dead"
      char = "x"
    end
    print "#{char} "
    puts if idx > 0 && idx % 2 == 0
  end
  puts
end

def tick_all cells
  cells.each do |idx,cell|
    cell.tick!
  end
end

output_all cells
tick_all cells
output_all cells
tick_all cells
output_all cells
tick_all cells
output_all cells


