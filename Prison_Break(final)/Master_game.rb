def read(x)
    File.readlines(x).each do |line|
    puts line
    end
end

read('Intro.txt')

class Scene
  def enter()
    puts "This scene is not yet configured. Subclass it and implement enter()."
    exit(1)
  end
end



class Cell < Scene
    def enter()
        read('Cell.txt')
        action = $stdin.gets.chomp
        if action == 'door'
            return 'hall'
        elsif action == 'window'
            return 'yard'
        else
            puts "invalid input"
            return 'cell'
        end
    end
end


class Hall < Scene
    def enter()
        read('Hall.txt')
        action = $stdin.gets.chomp
        if action == 'hall'
            return 'guard'
        elsif action == 'roof'
            return 'roof'
        else
            puts "invalid input"
            return 'hall'
        end
    end
end

class Yard < Scene
    def enter()
        read('Yard.txt')
        action = $stdin.gets.chomp
        if action == 'run'
            return 'run'
        elsif action == 'rush'
            read('Rush_yard.txt')
        else
            puts "invalid input"
            return 'yard'
        end
    end
end

class Guard < Scene
    def enter()
        read('Guard.txt')
        action = $stdin.gets.chomp
        if action == 'hide'
            return 'armory'
        elsif action == 'rush'
            read('Rush_hall.txt')
        else
            puts "invalid input"
            return 'guard'
        end
    end
end

class Armory < Scene
    def enter()
        read('Armory.txt')
        action = $stdin.gets.chomp
        if action == 'motorcycle'
            read('Motorcycle.txt')
        elsif action == 'truck'
            return 'truck'
        else
            puts "invalid input"
            return 'armory'
        end
    end
end

class Truck < Scene
    def enter()
        read('Truck_dashboard.txt')
        wires = ["red", "blue", "green", "yellow", "orange"]
        wire_1 = wires[(rand 0..4)]
        wire_2 = wires[(rand 0..4)] 
        user_1 = gets.chomp
        user_2 = gets.chomp
        
        if ((wire_1 == user_1) & (wire_2 == user_2) || (wire_2 == user_1) & (wire_1 == user_2))
            read('Truck_win.txt')
        elsif (user_1 == "back") & (user_2 == "door")
            read('Truck_win.txt')
        elsif !((wire_1 == user_1) & (wire_2 == user_2) || (wire_2 == user_1) & (wire_1 == user_2))
            read('Truck_lose.txt')
        else
            puts "broken"
        end
        
    end
end

class Run < Scene
    def enter()
        read('Run.txt')
        action = $stdin.gets.chomp
        if action == 'sewer'
            read('Sewer.txt')
        elsif action == 'fence'
            read('Fence.txt')
        else
            puts "invalid input"
            return 'run'
        end
    end
end

class Roof
    def enter()
        read('Roof.txt')
        action = $stdin.gets.chomp
        if action == "parachute"
            read('Parachute.txt')
        elsif action == "climb"
            read("Climb.txt")
        else
            puts "invalid input"
            return 'roof'
        end
    end
end
        
    
class Map
  @@scenes = {
    'cell' => Cell.new(),
    'hall' => Hall.new(),
    'guard' => Guard.new(),
    'armory' => Armory.new(),
    'truck' => Truck.new(),
    'yard' => Yard.new(),
    'run' => Run.new(),
    'roof' => Roof.new()
  }



  def initialize(start_scene)
    @start_scene = start_scene
  end


  def next_scene(scene_name)
    val = @@scenes[scene_name]
    return val
  end

  def opening_scene()
    return next_scene(@start_scene)
  end
end


class Engine

  def initialize(scene_map)
    @scene_map = scene_map
  end

  def play()
    current_scene = @scene_map.opening_scene()
    last_scene = @scene_map.next_scene('finished')
    while current_scene != last_scene
      next_scene_name = current_scene.enter()
      current_scene = @scene_map.next_scene(next_scene_name)
    end
    current_scene.enter()
  end
end

a_map = Map.new('cell')
a_game = Engine.new(a_map)
a_game.play()