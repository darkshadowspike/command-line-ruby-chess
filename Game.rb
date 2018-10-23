require "./test_board"

class Game

	attr_accessor :board, :wks , :bks, :win

	def initialize
		@board = Tboard.new
		@wks=0
		@bks=0
		@win = false
	end
   
    def play
    until @win do
     
     white_play
     
     black_play
    end
     @board.put_board
     puts "Bye"
    end

    def white_play
	    @board.put_board
	    if check(@board.wking.pos,true)
     	puts "your turn WHITE player, white king is in check!!!"
     	play_in_check(true)
        else
		   	puts "your turn WHITE player, choose wich piece to move , write the number of the piece you can move (write 'skip' to skip turn): "
		    avaible_pieces(@board.whites,true)
		    
		    choice=gets.chomp.upcase 
			   if choice != "SKIP" && choice !=""
			     begin
			     move_piece(choice,true)
			     rescue TypeError
				 puts "there is not piece  in that place, press start to try again"
				 gets
				 white_play
			     end
			   
			 
			   end
			
		end
    end

    def black_play
	    @board.put_board
	     if check(@board.bking.pos,false)
         puts "Your turn BLACK player, black king is in check!!!"
         play_in_check(false)
         else
		 puts "your turn BLACK player, choose wich piece to move , write the number of the piece you can move (write 'skip' to skip turn): "
		    avaible_pieces(@board.blacks,false)
		    
		    choice=gets.chomp.upcase 
		     if choice != "SKIP" && choice !=""
		     	 begin
			     move_piece(choice,false)
			     rescue TypeError
				 puts "there is not piece  in that place, press start to try again"
				 gets
				 black_play
			     end
			 end
			
		end
    end

    def check(king,white = false,king_test=false)
    n = false
    @wks=0
    @bks=0
    
    	if white
    		
    		@board.blacks.each do |element|
    		  element.table=element.ntable
              ind = element.table.find_vertice(element.pos)
            
              
              vertice = element.posible_moves(element.table.vertices[ind],@board.bpos,@board.wpos,white,king_test)
              
            
              if vertice.neighbours.include?(king)                 	 
              	#p "#{element.pos}:#{element.class}"
              	#p @board.bpos
              	#p king
              	#p vertice.neighbours
              	n = true            
                 @wks +=1                 
              end
    		end
    	else

    		@board.whites.each do |element|
    		  element.table=element.ntable
              ind = element.table.find_vertice(element.pos)
             
              vertice = element.posible_moves(element.table.vertices[ind],@board.wpos,@board.bpos,white,king_test) 

            
              if vertice.neighbours.include?(king)
                 # p "#{element.pos}:#{element.class}"
                 #p @board.wpos
                 # p king
                 # p vertice.neighbours
              	  n = true
              	 # element.table=element.ntable
              	  @bks +=1            
              end
    		end
    	end
    return n
    end

    

    def play_in_check(white=false)
    	if white
	    	n = @wks
	    else
	        n = @bks
	    end
	    if n <2 
	         can_move =[]
	         if white
	         	@board.whites.each do |element|	
	         	   if element.class != King       	 
			            if save_king(element,white)
			            	can_move.push(element)
			            end
		           end 
	         	end
	         	 can_move.push(@board.wking)
	         	 puts "you can move only:"
	         	 avaible_pieces(can_move,true)
                 choice=gets.chomp.upcase 
                 if choice ==""
                 puts "there is not piece  in that place, press start to try again"
				 gets
				 white_play
                 end 
	         	 begin
			     move_piece(choice,white,true)
			     rescue TypeError 
				 puts "there is not piece  in that place, press start to try again"
				 gets
				 white_play
			     end
	         else
	         	@board.blacks.each do |element|                
		             if element.class != King       	 
			            if save_king(element,white)
			            	can_move.push(element)
			            end
		             end 
	         	end
	         	can_move.push(@board.bking)
	         	puts "you can move only:"
	         	avaible_pieces(can_move,false)
			     choice=gets.chomp.upcase 
			     if choice ==""
                 puts "there is not piece  in that place, press start to try again"
				 gets
				 white_play
                 end 
	         	 begin
			     move_piece(choice,white,true)
			     rescue TypeError
				 puts "there is not piece  in that place, press start to try again"
				 gets
				 black_play
			     end

	         end
        else 
           checkmate
        end
        
       
    end

    def save_king(piece, white)
       
	      if white
		      	kind =  @board.wking.table.find_vertice(@board.wking.pos)
		        @board.wking.posible_moves(@board.wking.table.vertices[kind],@board.wpos,@board.bpos,white)
		       
		       @board.blacks.each do |element|
			       	 ind = element.table.find_vertice(element.pos)
			         if element.table.vertices[ind].neighbours.include?(@board.wking.pos)
			         ind2 = piece.table.find_vertice(piece.pos)
			         # p_m = piece.posible_moves(piece.table.vertices[ind2],@board.wpos,@board.bpos,white)
			     
			          m = piece.table.vertices[ind2].neighbours.map do |element2|

			              if element.table.vertices[ind].neighbours.include?(element2) &&  @board.wking.table.vertices[kind].neighbours.include?(element2)

			              element2 = element2
			              elsif element2 == element.pos
			               element2 = element2
			              else
			               element2 = nil
			              end

			           end
			          
			           piece.table.vertices[ind2].neighbours = m
			       end
		      end

	      else
	           kind = @board.bking.table.find_vertice(@board.bking.pos) 
	           @board.bking.posible_moves( @board.bking.table.vertices[kind],@board.bpos,@board.wpos,white)

	           @board.whites.each do |element|
	               ind = element.table.find_vertice(element.pos)

		          if element.table.vertices[ind].neighbours.include?(@board.bking.pos)
			        ind2 = piece.table.find_vertice(piece.pos)
			       # p_m = piece.posible_moves(piece.table.vertices[ind2],@board.bpos,@board.wpos,white)
			      
			           m = piece.table.vertices[ind2].neighbours.map do |element2|

			              if element.table.vertices[ind].neighbours.include?(element2) &&  @board.bking.table.vertices[kind].neighbours.include?(element2)

			              element2 = element2
			              elsif element2 == element.pos
			               element2 = element2
			              else
			               element2 = nil
			              end

			           end
			         
			           piece.table.vertices[ind2].neighbours = m
			        end
	            end
	      end
          ind2 = piece.table.find_vertice(piece.pos)
	      if piece.table.vertices[ind2].neighbours.all? {|element| element == nil}
	      return false
	      else
	      return true
	      end

    end

    

    def checkmate(white = false)
    	puts "CHECKMATE!"
    	if white
    	puts "player Black Wins , press start to quit, or enter 'rematch'  to play again"
    	choice = gets.chomp
	    	if choice == "rematch"
	    	g2 = Game.new
	    	g2.play
	    	else
	    	@win = true
	    	end
    	else
    	puts "player White Wins, press start to quit, or enter 'rematch'  to play again"
    	choice = gets.chomp
    	    if choice == "rematch"
	    	g2 = Game.new
	    	g2.play
	    	else
	    	@win = true
	    	end
    	end
    end

   def avaible_pieces(pieces,white=false)
   	 str=""
   	 if white
	   	 pieces.each do |element|
	   	 	str+="#{element.string_pos}:#{element.class}  "
	   	 end

   	 else 
	   	  pieces.each do |element|
	   	 	str+="#{element.string_pos}:#{element.class}  "
	   	 end
   	 end
   	 puts str + "\n"
   end

   def move_piece(choice, white = false,incheck = false)
	   	choice = [to_pos(choice[0]),choice[1].to_i]
        if @board.table[choice[0]][choice[1]].class == King
         move_king(@board.table[choice[0]][choice[1]],white) 
        else 
		 pos_change(choice,white,false,incheck)
		end
   end

   def  pos_change(choice,white,king=false,incheck=false)
         	if white
     
	            if @board.whites.include?(@board.table[choice[0]][choice[1]])
				   if king || @board.table[choice[0]][choice[1]].move(@board.wpos,@board.bpos,true,incheck)
					   	if @board.blacks.include?(@board.table[@board.table[choice[0]][choice[1]].pos[0]][@board.table[choice[0]][choice[1]].pos[1]])
					   
					   	eats(@board.table[@board.table[choice[0]][choice[1]].pos[0]][@board.table[choice[0]][choice[1]].pos[1]] , white)
					   	end 
					    normal_move(choice,white)
					else 
				    white_play 
					end 
				else 
                 puts "there is not piece  in that place, press start to try again"
				 gets
				 white_play
				end
			else 
			  if @board.blacks.include?(@board.table[choice[0]][choice[1]])
				if king || @board.table[choice[0]][choice[1]].move(@board.bpos,@board.wpos,false,incheck)
				   	if @board.whites.include?(@board.table[@board.table[choice[0]][choice[1]].pos[0]][@board.table[choice[0]][choice[1]].pos[1]])
				   	eats(@board.table[@board.table[choice[0]][choice[1]].pos[0]][@board.table[choice[0]][choice[1]].pos[1]] , white)
				   	end
                    normal_move(choice,white)
				else 
				black_play
				end
			  else
			  puts "there is not piece  in that place, press start to try again"
			  gets
			  white_play
			  end
            end
   end


   def normal_move(choice,white = false)
   	  @board.table[@board.table[choice[0]][choice[1]].pos[0]][@board.table[choice[0]][choice[1]].pos[1]] = @board.table[choice[0]][choice[1]] 
      
      if white
      	index1 = @board.wpos.index(choice)
      	@board.wpos=@board.wpos[0...index1]+@board.wpos[index1+1..-1]
      	@board.wpos.push(@board.table[choice[0]][choice[1]].pos)
      else
      	index1 = @board.bpos.index(choice)
      	@board.bpos=@board.bpos[0...index1]+@board.bpos[index1+1..-1]
      	@board.bpos.push(@board.table[choice[0]][choice[1]].pos)
      end
      @board.table[choice[0]][choice[1]] = @board.bs
   end

   def move_king(king,white)
   	   ind = king.table.find_vertice(king.pos)
   	   if white
       k = king.posible_moves(king.table.vertices[ind],@board.wpos,@board.bpos,white)
       else
       k = king.posible_moves(king.table.vertices[ind],@board.bpos,@board.wpos,white)
       end
      posible_m =[]
      k.neighbours.each do |element|
          if element
          	posible_m .push(element)
          end 
      end

      blocked_m =[]
      final_m =[]
      posible_m.each_with_index do |element,index|
         if check(element,white,true)
           blocked_m.push(element)
         else
           final_m.push(element)
         end
      end

	  if white && blocked_m == posible_m && check(@board.wking.pos,true)
	  	checkmate(white)
	  elsif  blocked_m == posible_m && check(@board.bking.pos,false)
	  	checkmate(white)
	  else

	  	if final_m.length ==0 
         puts " sorry, there not moves avaible for this piece , press start to choose another piece"
         gets
         white_play
        else 
	        strings_m = final_m.map do |element|
	        	element = king.string_pos(element)
	        end
	    old_pos = king.pos.dup
        king.pos_choice(strings_m)
        pos_change(old_pos,white,true)
        end       

	  end

   end

   



   def eats(eaten,white = false)
	  if white 
	  	index1 = @board.blacks.index(eaten)
	  	index2 = @board.bpos.index(eaten.pos)
	    @board.blacks=@board.blacks[0...index1]+@board.blacks[index1+1..-1]
	    @board.bpos=@board.bpos[0...index1]+@board.bpos[index1+1..-1]
	  else
	  	index1 = @board.whites.index(eaten)
	  	index2 = @board.wpos.index(eaten.pos)
	    @board.whites=@board.whites[0...index1]+@board.whites[index1+1..-1]
	    @board.wpos=@board.wpos[0...index1]+@board.wpos[index1+1..-1]
	  end
   end

   def to_pos(str)
        r= str.downcase
        case r
        when "a"
        r = 0
        when "b"
        r = 1
        when "c"
        r = 2
        when  "d"
        r = 3 
        when "e"
        r = 4
        when "f"
        r = 5
        when "g"
        r = 6
        when "h"
        r = 7
        end 
       return r   
    end


end

g= Game.new

g.play