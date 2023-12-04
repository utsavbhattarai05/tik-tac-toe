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
 
     return winning_combinations.any? do |combination|
      symbols = combination.map { |pos| @board[pos[0]][pos[1]] }
      symbols.uniq.length == 1 && symbols[0] != ''
    end
  end
 
  # Method to make a move for the current player
  def make_move(row, col)
    if @board[row][col] ==''
      @board[row][col] = @current_player
      switch_player
    else
      puts "Invalid move! Cell already taken. Try again."
    end
  end
 
  # Method to get a move from the user
# Method to get a move from the user
def game_loop
  loop do
    display_board
    get_move

    if check_win
      display_board
      puts "Player #{@current_player} wins!"
      break
    elsif board_full?
      display_board
      puts "The game is a draw!"
      break
    end

    switch_player  # Move the switch_player outside the else block
  end
end


def board_full?
  @board.flatten.none? { |cell| cell == '' }
end
  
  def get_move
    input = nil
    row = nil
    col = nil
    loop do
      puts "#{@current_player}'s turn. Enter your move (row, col):"
      input = gets.chomp
  
      if valid_input?(input)
        row, col = input.split(',').map(&:to_i)
        if @board[row][col] == ''
          @board[row][col] = @current_player
          display_board  # Display the board after a move
        
          if check_win
            puts "Player #{@current_player} wins!"
            break
          end
        
          switch_player
        else
          puts "Invalid move! Cell already taken. Try again."
        end
        
        
      
      else
        puts "Invalid input! Please enter a valid move in the format 'row, col' (e.g., '0,2')."
      end
    end
    
    make_move(row , col )
  end
  
  
  
  def switch_player
    @current_player = (@current_player == 'X' ? 'O' : 'X')
  end

  #Method to validate the user input
  def valid_input?(input)
    return false if input == '3'
  
    digits = input.split(',').map(&:strip)
  
    return false unless digits.length == 2
  
    digit1, digit2 = digits.map(&:to_i)
  
    (0..2).include?(digit1) && (0..2).include?(digit2)
  end
  
end



 #Create an instance of TicTacToe
#game = TicTacToe.new

# Call get_move on the instance
#game.game_loop


#to run the code
#require_relative
#game = TicTacToe.new
#game.game_loop
