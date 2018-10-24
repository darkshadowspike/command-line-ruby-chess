require "./class_Graph"

class Piece 

	attr_accessor :pos, :table, :symbol

	def initialize(pos=[0,0],symbol ="")
		#[X,Y]
        #pos = [X,Y]
        @pos=pos
        @table=ntable
        @symbol=symbol
	end

  


    def posible_moves(vertice,arr=[],arren=[],white=false,king_test=false)
        
    end

    def string_pos(pos=@pos)
        spos = pos.dup
       case spos[0]
            when 0
                spos[0]="A"
             when 1
                spos[0]="B"
             when 2
                spos[0]="C"
             when 3
                spos[0]="D"
             when 4
                spos[0]="E"
             when 5
                spos[0]="F"
             when 6
                spos[0]="G"
             when 7
                spos[0]="H"
             end
       return spos[0]+spos[1].to_s
    end

    def move(arr=[],arren=[], white=false, incheck = false )
        
        ind = @table.find_vertice(@pos)
        if incheck
        vertice = @table.vertices[ind]
        else
        vertice = posible_moves(@table.vertices[ind],arr,arren,white)
        end
        m = []
        vertice.neighbours.each do |element|
            if element
             m.push(element)
            end
        end
        m= m.map do |element|
            element = string_pos(element)
        end
        @table=ntable 
        if m.length ==0 
         puts " sorry, there not moves avaible for this piece , press start to choose another piece"
         gets
         return false
        else 
        pos_choice(m)
        return true
        end
    end

    def pos_choice(m)
       puts "you can move this piece to #{m} where do you want to move?"
       choice = gets.chomp.upcase 
        if m.include?(choice)
           choice = choice.split("")
           @pos =[to_pos(choice[0]),choice[1].to_i]
           else
            puts "invalid, try again"
            pos_choice(m)
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


    def ntable
     n =Graph.new
     i = 0
         while i<=7
         j = 0
            while j<=7
                n.add_vertex([j,i])
                j+=1
            end
         i+=1
         end
    return n
    end

    def connection      
         m = @table.vertices.map do |element|
          element= posible_moves(element)
        end        
    end
 

    def moves_route( move, start=@pos)

     connection
     fin = false
     n =[]
     ni =[]
     n.push(start)
     i=0
     until fin

             m = @table.find_vertice(start)

            if @table.vertices[m].neighbours.include?(move) || n[0][0]== move[0] && n[0][1]== move[1]
                ni.push(n.shift) 
                ni.push(move)
                fin = true
            break

            else

                 @table.vertices[m].neighbours.each_with_index do |element,index| 
                    if element && !ni.include?(element)
                      n.push(element)
                    end
                 end

                 ni.push(n.shift) 
                 start=n[0]   
                 
             end
                       
         
     end
    

    ni.reverse!
    path=[]
    path.push(ni[0])
    ni.each do |element|
      if @table.vertices[@table.find_vertice(path[-1])].neighbours.include?(element)
        path.push(element)
      end
    end
    path.reverse!
    @table=ntable
    puts "you can go there in #{path.length} steps:"
    p path
     
    end
     

end