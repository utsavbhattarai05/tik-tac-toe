class TicTacToe
  #private method section
  private

  def rows
    (0...@board_size).map { |row| (0...@board_size).map { |col| [row, col] } }
  end

  def columns
    (0...@board_size).map { |col| (0...@board_size).map { |row| [row, col] } }
  end

  def diagonals
    [
      (0...@board_size).map { |i| [i, i] },                  # Main diagonal
      (0...@board_size).map { |i| [i, @board_size - 1 - i] } # Anti-diagonal
    ]
  end
  #public method section
  public

  def initialize
    puts "Enter the board size (e.g., 3 for a 3x3 board):"
    @board_size = gets.chomp.to_i
    @board = Array.new(@board_size) { Array.new(@board_size, '') }
    puts"enter the who wnat to play first 'X' or 'O' "
    @current_player = gets.chomp.upcase
  end


  # Method to display the board
  def display_board
    puts " 0.. #{@board_size -1}"
     @board.each_with_index do |row, i|
       print "#{i} "
       row.each { |cell| print "#{cell}|" }
       puts "\n --|--|--|--"
     end
  end
 
 
  # Method to check if the game is won
  def check_win
     winning_combinations = rows + columns + diagonals
 
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

    continue
  end
  
  
  
  def switch_player
    @current_player = (@current_player == 'X' ? 'O' : 'X')
  end

  #Method to validate the user input
  def valid_input?(input)
    @a = @board_size-1
    return false if input == "#{@board_size}"
  
    digits = input.split(',').map(&:strip)
  
    return false unless digits.length == 2
  
    digit1, digit2 = digits.map(&:to_i)
  
    (0..@a).include?(digit1) && (0..@a).include?(digit2)
  end
end
def continue
  puts("Do you want to play again? Press (Y) for yes and (N) for no")
  choice = gets.chomp.upcase

  if choice == "Y"
    puts("Thank you for playing again")
    initialize  # Reset the game state
    game_loop
  elsif choice == "N"
    puts("Thank you for playing.")

    else
      puts("Press (Y) for yes and (N) for no")
  end
end


 #Create an instance of TicTacToe
game = TicTacToe.new

# Call get_move on the instance

game.game_loop


#to run the code
#require_relative
#game = TicTacToe.new
#game.game_loop
