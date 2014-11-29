require 'rspec'
require './lib/conmay.rb'

describe "neighbour counting interface" do

  before { @cell = Cell.new }
  subject { @cell.num_neighbours_alive }

  context "all empty neighbouring cells" do
    before { @cell.add_neighbours(Cell.new, Cell.new) }
    it { should == 0 } 
  end

  context "2 alive neighbouring cells" do
    before { @cell.add_neighbours(alive_cell, empty_cell, empty_cell, alive_cell, dead_cell) }
    it { should == 2 } 
  end
end

describe "cell occupancy interface" do
  before { @cell = Cell.new }
  subject { @cell.state }

  context "empty state" do
    it { should == "empty" } 
  end

  context "dead state" do
    before { @cell.state = "dead" }
    it { should == "dead" } 
  end

  context "alive state" do
    before { @cell.state = "alive" }
    it { should == "alive" } 
  end
end

describe "neighbours interface" do 
  before do 
    @cell1 = Cell.new
    @cell2 = Cell.new
    @cell3 = Cell.new
  end

  context "empty neigbhours" do
    before { @cell1.add_neighbours(@cell2, @cell3) }
    subject { @cell1.neighbours }
    it { should == [@cell2, @cell3] }
  end
  context "non-empty neigbhours" do
    before do 
      @cell1.add_neighbours(@cell2)
      @cell1.add_neighbours(@cell3)
    end
    subject { @cell1.neighbours }
    it { should == [@cell2, @cell3] }
  end
end

def alive_cell
  cell = Cell.new
  cell.state = "alive"
  cell
end

def empty_cell
  cell = Cell.new
  cell.state = "empty"
  cell
end

def dead_cell
  cell = Cell.new
  cell.state = "dead"
  cell
end

describe "tick! interface" do
  before do
    @cell = Cell.new 
  end

  subject { @cell.state }

  context "less than two neighbours" do
    before do 
      @cell.state = "alive"
      @cell.tick! 
    end

    it { should == "dead" }
  end

  context"two or three live neighbours" do
    context "alive" do
      before { @cell.state = "alive" }

      context "two" do
        before do 
          @cell.add_neighbours(alive_cell, alive_cell, dead_cell, empty_cell)
          @cell.tick!
        end
        it { should == "alive" }
      end

      context "three" do
        before do 
          @cell.add_neighbours(alive_cell, alive_cell, dead_cell, empty_cell, alive_cell)
          @cell.tick!
        end
        it { should == "alive" }
      end
    end
  end
 
  context "more than three alive neigbours" do
    before do 
      @cell.add_neighbours(alive_cell, alive_cell, alive_cell, alive_cell, dead_cell, empty_cell)
      @cell.state = "alive"
      @cell.tick!
    end
    
    subject { @cell.state } 
    it { should == "dead" }
  end

  context "exactly three live neighbours" do
    before { @cell.add_neighbours(alive_cell, alive_cell, alive_cell, dead_cell, empty_cell) }
    subject { @cell.state } 
    context "alive" do
      before do
        @cell.state = "alive"
        @cell.tick!
      end
      it { should == "alive" }
    end
    
    context "dead" do
      before do
        @cell.state = "dead"
        @cell.tick!
      end
      it { should == "alive" }
    end
  end
end
