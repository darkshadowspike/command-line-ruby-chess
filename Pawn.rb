require "./Piece"

class Pawn < Piece

	def posible_moves(vertice,arr=[],arren=[],white=false,king_test=false)
      
      if @color
	        start = vertice.name
	        if start[1] + 1 <=7
	            n = [@pos[0],start[1] + 1]
	            if !arr.include?(n) && !arren.include?(n)
	             @table.add_edge(start, n, 1 )
	            end
	       end

	        if start[0]+1 <=7 && start[1]+1 <=7 
	        	n = [start[0]+1,start[1] + 1]
	        	if arren.include?(n)
	            @table.add_edge(start, n, 1 )
	            end
	        end

	        if start[0]-1 >= 0 && start[1]+1 <=7 
	        	n = [start[0]-1,start[1] + 1]
	        	if arren.include?(n)
	            @table.add_edge(start, n, 1 )
	            end
	        end
      else 

      	  start = vertice.name
	        if start[1] - 1 >=0
	            n = [@pos[0],start[1] - 1]
	            if !arr.include?(n) && !arren.include?(n)
	             @table.add_edge(start, n, 1 )
	            end
	       end

	        if start[0]+1 <=7 && start[1]- 1 >=0
	        	n = [start[0]+1,start[1] - 1]
	        	if arren.include?(n)
	            @table.add_edge(start, n, 1 )
	            end
	        end

	        if start[0]-1 >= 0 && start[1]- 1 >=0
	        	n = [start[0]-1,start[1] - 1]
	        	if arren.include?(n)
	            @table.add_edge(start, n, 1 )
	            end
	        end
      end 
     
    return vertice
    end

end

