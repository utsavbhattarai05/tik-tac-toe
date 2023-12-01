class TicTacToe

  def initialize
     @board = Array.new(3) { Array.new(3, '') }
     @current_player = 'X'
  end
 
  # Method to display the board
  def display_board
    puts " 0 1 2"
     @board.each_with_index do |row, i|
       print "#{i} "
       row.each { |cell| print "#{cell}|" }
       puts "\n --|--|--|--"
     end
   end
 
 
  # Method to check if the game is won
  def check_win
     winning_combinations = [
       [[0, 0], [0, 1], [0, 2]],
       [[1, 0], [1, 1], [1, 2]],
       [[2, 0], [2, 1], [2, 2]],
       [[0, 0], [1, 0], [2, 0]],
       [[0, 1], [1, 1], [2, 1]],
       [[0, 2], [1, 2], [2, 2]],
       [[0, 0], [1, 1], [2, 2]],
       [[0, 2], [1, 1], [2, 0]]
     ]
 
     winning_combinations.each do |combination|
       symbols = combination.map { |pos| @board[pos[0]][pos[1]] }
       return true if symbols.uniq.length == 1 && symbols[0] != ' '
       false
     end
  end
 
  # Method to make a move for the current player
  def make_move(row, col)
     if @board[row][col] == ' '
       @board[row][col] = @current_player
       switch_player
     else
       puts "Invalid move! Cell already taken. Try again."
     end
  end
 
  # Method to switch the current player
  def switch_player
    @current_player = (@current_player == 'X' ? 'O' : 'X')
  end
 
  # Method to get a move from the user
  def get_move
    print "Enter the row and column for your move: "
    input = gets.chomp.downcase
  
    until valid_input?(input)
      puts "Invalid entry! Please enter again:"
      input = gets.chomp.downcase
    end
  
    row, col = input.split(',').map(&:to_i)
    make_move(row - 1, col - 1)
  end

  #Method to validate the user input
 def valid_input?(input)
   input =~ /^([1-3]),\s?([1-3])$/ || input == '4'
  end
end
