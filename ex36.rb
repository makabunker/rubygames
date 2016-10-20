puts "~~~~~Welcome to RUBY~~~~~"
puts "~a new and exciting game~"
puts "~~~~Let's get started~~~~"

$bank = 3
$prize = 0
$storage_locked = false
$casino_locked = false
$beyond_locked = true

def storage_room
	puts """
	^^^^^^^^^^^^^^^^^^^
	It's a damp and dusty room with three ceramic pots
	There's a sign that says \"Pick one, then get out!\"
	1 is small and squatty
	2 is tall and skinny
	3 is very mishapen
	^^^^^^^^^^^^^^^^^^^
	Which one do you pick?
	"""

	puts "> "
	choice = $stdin.gets.chomp
	puts choice

	if choice == "1"
		$prize = rand(3..8)
		puts "Pot 1 had $#{$prize} in it!"
	elsif choice == "2"
		$prize = rand(1..10)
		puts "Pot 2 had $#{$prize} in it!"
	elsif choice == "3"
		$prize = rand(5..6)
		puts "Pot 3 had $#{$prize} in it!"
	else
		puts "You should have picked one of the pots!"
		$prize = 0
	end
	$bank += $prize
	$storage_locked = true
end

def casino_room
	puts "Welcome to the Casino"
	puts "How much would you like to wager?"

	wager = $stdin.gets.chomp
	wager = wager.to_i

	if wager > $bank
		puts "You don't have that kind of money, partner"
	elsif wager <= $bank
		$bank -= wager
		mult = (rand(0.0...1.9)).round(1)
		$prize = mult * wager
		$prize.round(2)
		puts "Your wager was multiplied #{mult} times!"
		if mult <= 1.0
			puts "You lost $#{wager - $prize}"
		else
			puts "You won $#{$prize - wager}"
		end
		$bank += $prize
		$prize = 0
	end
end

def key_room
	puts "C"
end

def beyond_room
	puts "D"
end

def dead
	puts "Goodbye!"
	exit
end





def start
	puts """
	^^^^^^^^^^^^^^^^^^^
	You find yourself in a dimly lit corridor
	There are four doors in front of you labeled
	\"Storage\" \"Casino\" \"Key Room\" \"The Beyond\"
	^^^^^^^^^^^^^^^^^^^
	Which one do you open?
	"""

	puts "> "
	choice = $stdin.gets.chomp

	if choice == "Storage" && $storage_locked == false
		storage_room
		puts "The door 'clicked' after you left."
	elsif choice == "Storage" && $storage_locked == true
		puts "The room is locked!"
	elsif choice == "Casino" && $casino_locked == false
		casino_room
		puts "Come back soon!"
	elsif choice == "Casino" && $casino_locked == true
		puts "The Casino is closed!"
	elsif choice == "Key Room"
		key_room
	elsif choice == "The Beyond" && $beyond_locked == false
		beyond_room
	elsif choice == "The Beyond" && $beyond_locked == true
		puts "This room is locked!"
	else
		dead
	end
end

while true
	start
	puts $bank
end
