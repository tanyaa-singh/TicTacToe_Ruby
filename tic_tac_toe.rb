class Board
	def initialize(size)
		@size=size
		@board = Array.new(size) { Array.new(size, " ") }
	end

	def printInstructions
		i=1
		(0..@size-1).each do |row|
			print" 		"
			(0..@size-1).each do |col|
				print i
				i+=1
				print " 	|	 " unless col==@size-1

			end
			print "\n"
			print" 		"
			(0..@size-1).each do |col|
				print " 	|	 " unless col==@size-1
			end
			print "\n"
			print" 	"
			(0..@size-1).each do |i|
			print "----------------" unless row==@size-1
			end
			print"\n"
		end
		print "\n"
	end
	    

    def printBoard
    	(0..@size-1).each do |row|
			print" 		"
			(0..@size-1).each do |col|
				print @board[row][col]
				print " 	|	 " unless col==@size-1

			end
			print "\n"
			print"		"
			(0..@size-1).each do |col|
				print " 	|	 " unless col==@size-1
			end
			print "\n"
			print" 	"
			(0..@size-1).each do |i|
			print "----------------" unless row==@size-1
			end
			print "\n"
		end
		print "\n"
	end

	def isTie
    	@board.join.split('').include?(" ")
    end

    def findWinner
    	####onerowmatch###
	    (0..@size-1).each do |row|
	
			col=0
	    	if @board[row][col]=="X"
	   			while col<@size && @board[row][col]=="X" 
	   				col+=1
	   			end
	   			if col==@size
	    			return @board[row][0]
	    		end
	    	end
	    	
	    	col=0
	   		if  @board[row][col]=="O"
	   			while col<@size && @board[row][col]=="O" 
	   				col+=1
	   			end
    			if col==@size
	    			return @board[row][0]
	    		end
	    	end
	    end		
		####onecolumnmatch####
	    (0..@size-1).each do |col|
			
			row=0
	    	if @board[row][col]=="X"
	    		while row<@size && @board[row][col]=="X" 
	   				row+=1
	   			end
	   			if(row==@size)
	   				return @board[0][col]
	   			end
	   		end
	   		row=0
	   		if @board[row][col]=="O"
	   			while row<@size && @board[row][col]=="O" 
	   				row+=1
	   			end
    			if row==@size
	    			return @board[0][col]
	    		end
	    	end
	    end

	    if @board[0][0]==@board[1][1]
	    	
	    	i=0
	    	if(@board[i][i]=="X")
	  
	    		while i<@size && @board[i][i]=="X"  
	    			i+=1
	    		end
	    		if(i==@size)
	    			return @board[0][0]
	    		end
	    	end
	    	i=0
	    	if @board[i][i]=="O"
	    		
	    		while i<@size && @board[i][i]=="X" 
	    			i+=1
	    		end
	    		if(i==@size)
	    			return @board[0][0]
	    		end
	    	end

	    end

	    if @board[0][@size-1]==@board[1][@size-2]
	    	i=0
	    	if(@board[i][@size-i-1]=="X")
	  
	    		while i<@size && @board[i][@size-i-1]=="X"  
	    			i+=1
	    		end
	    		if(i==@size)
	    			return @board[0][@size-1]
	    		end
	    	end
	    	i=0
	    	if @board[i][@size-1-i]=="O"
	    		
	    		while i<@size && @board[i][@size-1-i]=="O" 
	    			i+=1
	    		end
	    		if(i==@size)
	    			return @board[0][@size-1]
	    		end
	    	end

	    end

	    return "C" unless isTie

	    return false
	end

	def is_empty(row,col)
        @board[row][col] === " "
    end

    def inside_board(row,col)
        (0..@size) === row and (0..@size) === col
    end

    def valid_move(row,col)
        is_empty(row,col) and inside_board(row,col)
    end

    def dropPiece(piece, row, col)
        @board[row][col] = piece if valid_move(row,col)
    end
  
end



def clear_screen
    puts "\n" * 10
end

def prompt_move(active_player,size)
    puts " #{active_player}'s turn. Choose a box!",
         "        **~V~**"
    print "           "

    move = gets.chomp.to_i - 1
    row = move / size
    col = move % size
    return row,col
end


def alert_winner(winner,board)
    puts "   --**~^^^^^^^~**--"
    if winner == "C"
      puts "   C A T S   G A M E"
    else
      puts "     #{winner} ' S   W I N"
    end

  puts "   ----**~vVv~**----"
  puts "\n"
  board.printBoard
  puts "\n        **~V~**"
end

def ticTacToe(boardClass,size)
    board = boardClass.new(size)
    active_player = "X"

    clear_screen
    board.printInstructions

    while not board.findWinner

    	row,col = prompt_move(active_player,size)
    	clear_screen

	    if board.dropPiece(active_player, row, col)
	      if active_player == "X"
	        active_player = "O"
	      else
	        active_player = "X"
	      end
	    else
	      puts "                 Invalid move, please select again\n\n"
        end

    	board.printBoard
	end

	winner = board.findWinner
	clear_screen
    alert_winner(winner,board)
end


while true
	clear_screen
	puts "Do you want to play again? (y/n)"
	if ["no","n"].include? (gets.chomp.downcase)
        puts "Goodbye"
	    break
	end
	puts"Enter the size of board"
	size=gets
	ticTacToe(Board,size.to_i)
end



