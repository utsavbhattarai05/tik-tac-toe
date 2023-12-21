
require_relative 'tiktactoe' 

  describe "#initialize" do
    it " ask the user for the first player" do
      allow(game).to receive(:gets).and_return("X\n")
      expect { game.send(:get_players) }.to output(/Enter who wants to play first/).to_stdout
    end

    it "ask the user for the board size" do
      allow(game).to receive(:gets).and_return("3\n")
      expect { game.send(:get_board_size) }.to output(/Enter the board size/).to_stdout
    end

    it "initializes the board correctly" do
      game.send(:initialize_board)
      expect(game.instance_variable_get(:@board)).to eq([['', '', ''], ['', '', ''], ['', '', '']])
    end
  end

  describe "#valid_input?" do
    it "returns true for valid input" do
      game.instance_variable_set(:@board_size, 3)
      expect(game.send(:valid_input?, "1,2")).to be true
    end

    it "returns false for invalid input" do
      game.instance_variable_set(:@board_size, 3)
      expect(game.send(:valid_input?, "4,2")).to be false
    end
  end

  describe "#make_move" do
    it "updates the board with the player's move" do
      game.instance_variable_set(:@current_player, 'X')
      game.send(:make_move, 1, 2)
      expect(game.instance_variable_get(:@board)).to eq([['', '', ''], ['', '', 'X'], ['', '', '']])
    end

    it "switches the player after a valid move" do
      game.instance_variable_set(:@current_player, 'X')
      game.send(:make_move, 1, 2)
      expect(game.instance_variable_get(:@current_player)).to eq('O')
    end

    it "prints an error message for an invalid move" do
      game.instance_variable_set(:@board, [['', '', ''], ['', 'X', ''], ['', '', '']])
      expect { game.send(:make_move, 1, 1) }.to output(/Invalid move! Cell already taken/).to_stdout
    end
  end

  describe "#check_win" do
    it "returns true when a player wins horizontally" do
      game.instance_variable_set(:@board, [['X', 'X', 'X'], ['', '', ''], ['', '', '']])
      expect(game.send(:check_win)).to be true
    end

    it "returns true when a player wins vertically" do
      game.instance_variable_set(:@board, [['O', '', ''], ['O', '', ''], ['O', '', '']])
      expect(game.send(:check_win)).to be true
    end

    it "returns true when a player wins diagonally" do
      game.instance_variable_set(:@board, [['', '', 'X'], ['', 'X', ''], ['X', '', '']])
      expect(game.send(:check_win)).to be true
    end

    it "returns false when no player wins" do
      game.instance_variable_set(:@board, [['X', 'O', 'X'], ['O', 'X', 'O'], ['X', 'O', 'X']])
      expect(game.send(:check_win)).to be false
    end
  end

  describe "#board_full?" do
    it "returns true when the board is full" do
      game.instance_variable_set(:@board, [['X', 'O', 'X'], ['O', 'X', 'O'], ['X', 'O', 'X']])
      expect(game.send(:board_full?)).to be true
    end

    it "returns false when the board is not full" do
      game.instance_variable_set(:@board, [['X', 'O', ''], ['O', '', 'O'], ['X', 'O', 'X']])
      expect(game.send(:board_full?)).to be false
    end
  end

  describe "#get_move" do
    it "prompts the user for a move until a valid move is entered" do
      allow(game).to receive(:gets).and_return("1,2", "invalid", "0,1")
      expect { game.send(:get_move) }.to output(/Enter your move/).to_stdout
    end
  end

  describe "#switch_player" do
    it "switches the current player from X to O" do
      game.instance_variable_set(:@current_player, 'X')
      game.send(:switch_player)
      expect(game.instance_variable_get(:@current_player)).to eq('O')
    end

    it "switches the current player from O to X" do
      game.instance_variable_set(:@current_player, 'O')
      game.send(:switch_player)
      expect(game.instance_variable_get(:@current_player)).to eq('X')
    end
  end

  # Add more tests for other methods as needed

  describe "#continue" do
    it "asks the user if they want to play again" do
      allow(game).to receive(:gets).and_return("Y\n")
      expect { game.send(:continue) }.to output(/Do you want to play again/).to_stdout
    end
  end



