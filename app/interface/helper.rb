class String
    def is_integer?
      self.to_i.to_s == self
    end
  end

class ClassHelpers
    def self.SplashASCII

        welcome = <<-SPLASH       

        *************** BIKER APP ***************
        *****************************************
SPLASH
        puts welcome
    end
end

module Screen
  def self.clear
    print "\e[2J\e[f"
  end
end