class Animal
    def initialize(name)
      @name = name
    end
  
    def speak
      raise NotImplementedError, 'This method must be overridden in a subclass'
    end
  end
  
  class Kangaroo < Animal
    def speak
      "#{@name} is hopping!"
    end
  end
  
  class Koala < Animal
    def speak
      "#{@name} says, 'Eucalyptus!'"
    end
  end
  
  def make_animal_speak(animal)
    raise ArgumentError, "Expected Animal instance, got #{animal.class}" unless animal.is_a?(Animal)
    
    animal.speak
  end
  
  kangaroo = Kangaroo.new("Skippy")
  koala = Koala.new("Cuddly")
  
  puts make_animal_speak(kangaroo) # "Skippy is hopping!"
  puts make_animal_speak(koala) # "Cuddly says, 'Eucalyptus!'"
  