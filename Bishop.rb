require "./Piece"
class Bishop < Piece
	def posible_moves(vertice,arr=[],arren=[],white=false,king_test=false)
        #pos = [X,Y]

        
	 	start = vertice.name 
        rightup = false
        leftup = false
        rightdown =false
        leftdown = false

        i = 1
        until rightup  do
        	if start[0] + i <=7 && start[1] + i <=7 
        		n = [start[0] + i,start[1] + i]
			        if !king_test
		           if arr.include?(n)
					   break
				   elsif arren.include?(n)			   	  
					   @table.add_edge(start, n, 1 )
					   
	                   rightup = true
				       break
				   else
					   @table.add_edge(start, n, 1 )
				   end
				 else
			     @table.add_edge(start, n, 1 )
			     end
        	else 
            rightup = true
        	end 
        	i+=1
        end

       
        i = 1

        until rightdown  do
        	if start[0] + i <=7 && start[1] - i >=0
        		n = [start[0] + i, start[1] - i]
        	      if !king_test
	           if arr.include?(n)
				   break
			   elsif arren.include?(n)			   	  
				   @table.add_edge(start, n, 1 )
				   
                   rightdown= true
			       break
			   else
				   @table.add_edge(start, n, 1 )
			   end
			 else
		     @table.add_edge(start, n, 1 )
		     end
        	else 
            rightdown  = true
        	end 
        	i+=1
        end

        i = 1

        until leftup  do
        	if   start[0] - i >= 0 && start[1] + i <=7 
        		n = [start[0] - i ,start[1] + i]
        	    if !king_test
	              if arr.include?(n)
				   break
			      elsif arren.include?(n)			   	  
				   @table.add_edge(start, n, 1 )
				   
                     leftup = true
			       break
			       else
				     @table.add_edge(start, n, 1 )
			       end
			   else
		       @table.add_edge(start, n, 1 )
		       end
        	else 
            leftup = true
        	end 
        	i+=1
        end

        i = 1

        until leftdown do
        		if  start[0] - i >= 0 &&  start[1] - i >= 0 
        		n = [start[0] -i  ,start[1] - i]
        	    if !king_test
	              if arr.include?(n)
				   break
			      elsif arren.include?(n)			   	  
				   @table.add_edge(start, n, 1 )
				   
                     leftdown = true
			       break
			       else
				     @table.add_edge(start, n, 1 )
			       end
			   else
		       @table.add_edge(start, n, 1 )
		       end
        	else 
            leftdown = true
        	end 
        	i+=1
        end
       

        return vertice
	 end
end

