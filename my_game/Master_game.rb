require './des_1,1.txt'
# require all of the room descriptions

class Players
    def initialize
        #this code will ask you to set up a charecter, defining its state
    end   
end

class enemies
    def enter
        #this code will set up the stats for enimies
   end 
end

class enemy_(1,1) < enemies
    def enter
        #this code will define the carecteristics for the stats of the enemy, 
        #as outlined in plan.txt
    end
end
# the above class will be repeated for each monster, in each room

class room
    def enter()
    puts "This room does not exist. Subclass it and implement enter()."
    exit(1)
  end
end

class room_(1,1) < room
    @@quips  [
        txt_(1,1).read
        ]
    end
end


class Engine

  def initialize(room_map)
    @room_map = room_map
  end

  def play()
    current_room = @room_map.opening_scene()
    last_room = @room_map.next_room('finished')

    while current_room != last_room
      next_room_name = current_room.enter()
      current_room = @room_map.next_room(next_room_name)
    end

    
    current_room.enter()
  end
end