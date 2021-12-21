class Fighter 
    attr_accessor :defense, :strength, :luck, :life, :mental
    attr_reader :name, :skill, :count
    attr_writer :count

    def initialize (name)
        @name = name 
        @defense = rand(5..8)
        @strength = 10
        @luck = 10
        @life = 100
        @mental = 10
        @count = 1
        @skill = "noob"
    end
    def stats
        p "Defense is #{defense}"
        p "Strength is #{strength}"
        p "Health is #{life}"
        p "#{name} is considered a #{skill}"
    end

    def attack opponent
        dmg = @strength - opponent.defense
        if dmg < 0
            puts "#{name} should have done more strength training, #{dmg} more strength needed"
        else
            opponent.life -= dmg
            puts opponent.life 
            if opponent.life < 0
                opponent.life = 0
            end
            puts "#{opponent.name} took #{dmg} damage and now has #{opponent.life} life"
            if opponent.life <= 0
                puts "#{opponent.name} has fainted"
            end
        end
    end

    def train
        @count += 1
        puts @count
        if @count > 3 && @count < 5
            @skill = "amateur"
        elsif @count > 5 && @count < 8
            @skill = "semi-pro"
        elsif @count > 8
            @skill = "pro"
        end
    end
end

class Dojo
    def self.lift_weights fighter
        fighter.train
        fighter.strength += 2
        p "#{fighter.name} pumps some iron"
    end 
    def self.endurance_training fighter
        laps = rand(1..100)
        fighter.train
        fighter.defense += 1
        p "#{fighter.name} runs #{laps} laps"
        if laps > 50 && laps < 75
            fighter.defense +=1
            puts "Great run!"
        elsif laps > 75
            fighter.defense +=2
            fighter.life -= 5
            puts "Ran so much it hurts"
        end
    end
    def self.coin_in_fountain fighter
        fighter.train
        number = fighter.luck - 6
        mod = rand(-2..number)
        fighter.strength += mod
        puts "#{fighter.name} throws a coin in fountain and magically changes strength by #{mod}"
    end
    def self.rest fighter
        puts "#{fighter.name} takes a nice hot bath"
        fighter.train
        if fighter.life + 20 >= 100
            fighter.life = 100
        else 
            fighter.life +=20
        end
    end
    def self.spar fighter
        puts "#{fighter.name} spars all day"
        fighter.train
        fighter.life -= 25
        fighter.strength += 2
        fighter.defense += 2
    end
end


puts "Welcome to Dojo Fighter\nPlease enter your name"
name = gets.chomp
puts "Welcome to the game #{name}"
# create new fighter
player = Fighter.new name
opponent = Fighter.new name.reverse.downcase!.capitalize()
sleep(1)

while player.count < 11
    puts "TURN #{player.count}"
    player.stats
    puts "Do you want to |Spar| ,|Lift|, |Cardio|, |Rest|, or |throw coin in fountain|?"
    input = gets.chomp #chomp trims whitespace  
    input.downcase!
    if input == "spar"
        Dojo.spar player
    elsif input == "cardio"
        Dojo.endurance_training player
    elsif input == "lift"
        Dojo.lift_weights player
    elsif input == "rest"
        Dojo.rest player
    elsif input == "throw coin in fountain"
        Dojo.coin_in_fountain player
    end
    ran_num = rand(1..4)
    if ran_num == 1 && opponent.count <=10
        Dojo.spar opponent
    elsif ran_num == 2 && opponent.count <=10
        Dojo.endurance_training opponent
    elsif ran_num == 3 && opponent.count <=10
        Dojo.lift_weights opponent
    elsif ran_num == 4 && opponent.count <=10
        Dojo.coin_in_fountain opponent
    end
    puts "\n\n"
end
Dojo.rest opponent
puts "The big battle has arrived"
player.stats
opponent.stats
while player.life > 0 && opponent.life > 0
    player.attack(opponent)
    opponent.attack(player)
    if player.life <=0 && opponent.life <0
        puts "you have tied"
    elsif player.life <=0 
        puts "you have lost"
    elsif opponent.life <=0 
        puts "you have won"
    end
end
