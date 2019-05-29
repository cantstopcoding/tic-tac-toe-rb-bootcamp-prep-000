WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  counter = 0 
  board.each do |index|
    if index == "X" || index == "O"
      counter += 1 
    end   
  end 
  return counter
end 

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end 

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  filtered_board = board.reject{|empty_space| empty_space == " "}
  if filtered_board.length == 9 
    return true
  else 
    false
  end 
end 

def draw?(board)
  !won?(board) && full?(board)
end 

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
 
  position_1 = board[win_index_1] 
  position_2 = board[win_index_2] 
  position_3 = board[win_index_3] 
 
  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return "X" 
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return "O"
  end
end
  nil
end   

def play(board)
  until over?(board)
    turn(board)
  end 
  
  if won?(board) 
    puts "Congratulations #{winner(board)}!"
  end
end 