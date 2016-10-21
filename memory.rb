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

class Scene
  def enter()
    puts "This scene is not yet configured. Subclass and implement enter()."
    exit(1)
  end
end

class Intro < Scene
  def enter()
    puts """
    WELCOME! We're about to take an exciting journy through
    one of the most interesting parts of your brain--The Papez
    Circuit (pronounced like 'paper' but without the 'er' sound).
    This is circuit through which all of your memories travel
    before being stored. Any disruption of this loop will prevent you
    from remembering new things you learn and experience. So make sure
    to keep your hands and legs inside the vehicle at all times. LETS GO!
    ...
    ...
    ...
    """
  return 'hippocampus'
  end
end

class Hippocampus < Scene

  def enter()

    puts """
    Alright, first stop is the Hippocampus. This is a very exciting and
    important area of your brain. After traveling through the entire circuit,
    your memory will return to the Hippocampus to be stored. Also, it's fun
    to say the name because it sounds like you're about to meet a family of
    hippopotomi on their annual camping trip.

    Let's take something with us through the Papez Circuit so we can remember
    it for a long time. Write down something interesting that you want
    to remember.
    """
    memory = $stdin.gets.chomp
    puts "Great. Now let's keep going"
    puts "...\n...\n..."
    return 'hypothalamus'
  end
end

class Hypothalamus < Scene

  def enter()
    puts'''
    Next stop: The Hypothalamus. This is an area close to the middle of your
    brain, and it does a lot of different things. Some of its most famous
    functions are involved in learning new things, processing emotions like
    fear, and telling the body which hormones to send out.

    In order to move on through the circuit, answer one question:
    Which of the following is a function of the Hypothalamus?
    (a) helping us decide what to eat for breakfast
    (b) helping our muscles move
    (c) telling our bodies when we\'re hot or cold
    (d) telling our bodies which hormones to send out
    '''
    choice = $stdin.gets.chomp
    if choice == 'd'
      puts "Wonderful. We're on our way"
      puts "...\n...\n..."
      return 'mammillary_body'
    else
      puts "Oops. Try again."
      return 'hypothalamus'
    end
  end
end

class Mammillary_Body < Scene

  def enter()
    puts """
    Well, well, what have we got here? The Mammillary Bodies! Small
    but powerful. In fact, when these bodies aren't working people can have
    all sorts of problems from Alzheimer's disease to heart failure. Yikes!
    What's more interesting is that neuroscientists still don't know the exact
    function of this part of your brain. Although, we do know that it's
    important for memories.
    """
    puts "Can you use your brain to decode this word?"
    puts "\n\t14 5 21 18 15 19 3 9 5 14 3 5"
    guess = $stdin.gets.chomp
    if guess == "neuroscience"
      puts "Impressive! You're frontal lobe must be top notch."
      puts "We're making good progress."
      puts "...\n...\n..."
      return 'thalamus'
    else
      puts "Give it another shot."
      return 'mammillary_body'
    end
  end
end

class Thalamus < Scene

  def enter()
    puts """
    You may be wondering, \"How do we get from one structure to the next?\"
    Well...let me tell you. Brains are FULL of special cells called NEURONS.
    Some of these neurons have the special job of taking information around
    the brain. You can think of them like the trains, planes, and automobiles
    of your mind. But they usually travel much, much faster than we can
    on our highways. From the Mammillary Bodies, neurons have brought us to
    the Thalamus.\n
    """
    found = 0
    while found < 3
      puts "Can you find 3 brain-related words we've discovered today?"
      puts """\n
      E I B N S L D K N H
      U T B K G D W S E N
      F I O L M C V A U R
      M E M O R Y G C R O
      G F Z W P L R T O K
      D A Q B B R A I N L
      P O Z C U E S T W N\n
      """
      puts "> "
      guess = $stdin.gets.chomp

      if guess == "NEURON" || guess == "neuron" || guess == "BRAIN" || guess == "brain" || guess == "MEMORY" || guess == "memory"
        puts "You got one!"
        found +=1
        puts "#{3 - found} to go."
      else
        puts "Sorry, I didn't find the same one"
      end
    end
    puts "Keep on keeping on. We're almost there!"
    puts "...\n...\n..."
    return 'cingulate_gyrus'
  end
end

class Cingulate_Gyrus < Scene

  def enter()
    puts """
    We're rounding third and on our way home. In order to fully process the
    information in your memory, we have to pass through the Cingulate Gyrus.
    This area of your brain links behaviors to emotions and memories, which
    helps you learn. For example: let's say you decide to eat a hot chocolate
    chip cookie with a glass of cold milk (score!). You'll probably feel a lot
    of good things. The Cingulate Gyrus helps you link those feelings with that
    specific action. So in the future, when you want something to help you feel
    good, you might reach for the cookies and milk. Good choice!

    Cingulate Gyrus is kind of an interesting name.
    If you could rename it to anything, what would it be?
    """
    name = $stdin.gets.chomp
    puts """
    Whoa! \"#{name}\" is a good choice. I'll propose that at
    the next neuroscientist convention. I'm sure it will
    get a excellent response.
    """
    return 'finished'
  end
end

class Finished < Scene
  def enter()
    puts "You did it! You made it back to the Hippocampus, and now your"
    puts "memory is stored. Make sure to access that memory every"
    puts "now and then to keep it sharp. Happy Remembering."
  end
end

class Map

  @@scenes = {
    'intro' => Intro.new(),
    'hippocampus' => Hippocampus.new(),
    'hypothalamus' => Hypothalamus.new(),
    'mammillary_body' => Mammillary_Body.new(),
    'thalamus' => Thalamus.new(),
    'cingulate_gyrus' => Cingulate_Gyrus.new(),
    'finished' => Finished.new(),
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

a_map = Map.new('intro')
a_game = Engine.new(a_map)
a_game.play()
