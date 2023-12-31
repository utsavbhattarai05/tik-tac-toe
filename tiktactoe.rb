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
  puts "Enter who wants to play first 'X' or 'O':"
  @current_player = gets.chomp.upcase
  if ['X', 'O'].include?(@current_player)
    @other_player = (@current_player == 'X') ? 'O' : 'X'
    else
      puts "Invalid input! Please enter either 'X' or 'O'"
      return initialize
  end

end



  # Method to display the board
  def display_board
    puts " 0.. #{@board_size -1}"
     @board.each_with_index do |row, i|
       print "#{i} "
       row.each { |cell| print "#{cell}|" }
       puts "\n --|-|-|--"
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
      continue
      return  # Use return instead of break
     elsif board_full?
      display_board
      puts "The game is a draw!"
      return  # Use return instead of break
    end
    switch_player
  end
  continue
end


def board_full?
  @board.flatten.none? { |cell| cell == '' }
end
  
def get_move
  loop do
    input = get_user_input

    if valid_input?(input)
      row, col = parse_input(input)
      valid_move_check(row, col) 
      return
      continue # Pass row and col as arguments
    else
      puts "Invalid input! Please enter a valid move in the format 'row, col' (e.g., '0,2')."
    end
  end
end

def valid_move_check(row, col)
  if valid_move?(row, col)
    make_and_display_move(row, col)
    verify_win
    return
    switch_player
  else
    puts "Invalid move! Cell already taken. Try again."
  end
end



 def verify_win
  if check_win  
   puts "Player #{@current_player} wins!"
   return 
  end 
end
def get_user_input
  puts "#{@current_player}'s turn. Enter your move (row, col):"
  gets.chomp
end

def parse_input(input)
  input.split(',').map(&:to_i)
end

def valid_move?(row, col)
  @board[row][col].empty?
end

def make_and_display_move(row, col)
  @board[row][col] = @current_player
  display_board
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
