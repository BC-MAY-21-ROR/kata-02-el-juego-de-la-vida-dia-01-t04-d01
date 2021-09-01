# frozen_string_literal: true

# Class for instantiate a game for The game of life
class GameOfLife
  def initialize
    @rows = 6
    @columns = 10
    @cells = rand(1..(@rows * @columns))
    initial_matriz = create_matrix
    first_gen = populate_random(initial_matriz)
    next_gen = next_generation(first_gen)
    puts 'Generation 1:'
    print_matrix(@temp_universe)
    puts 'Generation 2:'
    print_matrix(@new_generation)
  end

  # Create Grid
  def create_matrix
    Array.new(@rows) { Array.new(@columns, 0) }
  end

  # Print Grid
  def print_matrix(matrix)
    (1..matrix.size - 2).each do |f|
      (1..matrix[f].size - 2).each do |c|
        case matrix[f][c]
        when 0
          print " .\t"
        when 1
          print " *\t"
        end
      end
      print "\n"
    end
    print "\n"
  end

  def fill_matrix
    (0..@matrix.size - 1).each do |r|
      (0..@matrix[r].size - 1).each do |c|
        @matrix[r][c] = 0
      end
    end
  end

  def populate_random(matrix)
    (1..matrix.size - 2).each do |r|
      (1..matrix[r].size - 2).each do |c|
        matrix[r][c] = rand(0..1)
      end
    end
    matrix
  end

  # Method for the next generation universe of cells
  def next_generation(matrix)
    @temp_universe = matrix
    @new_generation = create_matrix
    (1..@temp_universe.size - 2).each do |r|
      (1..@temp_universe[r].size - 2).each do |c|
        # verify our universe and set if a cell will be alive or will die
        cell = @temp_universe[r][c]
        # verify alive neighbours
        alives = alive_neighbors(r, c)
        if cell == 1
          if alives < 2
            @new_generation[r][c] = 0
          elsif [2, 3].include?(alives)
            @new_generation[r][c] = 1
          elsif alives > 3
            @new_generation[r][c] = 0
          end
        elsif cell.zero? && alives == 3
          @new_generation[r][c] = 1
        end
      end
    end
    @new_generation
  end

  def alive_neighbors(r, c)
    alives = 0
    # Verify all the adyacent cells and sum their values (0/1)
    (return unless r.positive? && c.positive? && r < @rows - 1 && c < @columns - 1)
    alives = @temp_universe[r - 1][c - 1] + @temp_universe[r][c - 1] + @temp_universe[r + 1][c - 1] + @temp_universe[r - 1][c] + @temp_universe[r + 1][c] + @temp_universe[r - 1][c + 1] + @temp_universe[r][c + 1] + @temp_universe[r + 1][c + 1]
  end
end
GameOfLife.new
