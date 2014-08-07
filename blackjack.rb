#Author  : ken mcfadden
#Context : Tealeaf Academy course 1
#Abstract: Blackjack command line game.


# CONSTANTS & variable housekeeping
  BLACKJACK = 21
  DEALERMUSTHIT = 17
  BUST = 22
  YES = "y"
  NO = "n"
  QUIT = "q"
  STAY = "s"
  HIT = "h"
  STAND = "s"
  RULES = "Overview of rules: One player vs. the house
 1. The players are dealt cards to try and reach the sum of 21 or blackjack.
 2. The game starts with each player being dealt two cards.
 3. All face cards are worth their value, all suit cards are worth 10, and an Ace is worth either 11 or 1.
 4. The player goes first.  He/she may either hit or stay.  If you go over 21 you bust.
 5. The dealer must hit until at least 17 is reached.  House may hold before 21.
 6. If neither player reaches 21, the player closest wins without going over 21 or busting."

  winner = []
  house_hand = []
  house_stands = false
  house_bust = false
  player_hand = []
  player_stands = false
  player_bust = false
  card_suits = %W(S C H D)
  card_suit_names = {"S" => "Spades", "C" => "Clubs", "H" => "Hearts", "D" => "Diamonds"}
  card_values = {"2" => 2,"3"=>3,"4"=>4,"5"=>5,"6"=>6,"7"=>7,"8"=>8,"9"=>9,"10"=>10,"J"=>10,"Q"=>10,"K"=>10,"A"=>11}
  card_types = ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]

  deck = card_types.product(card_suits) # create base deck
  new_deck = deck.shuffle # shuffle the deck before we start


  # Methods to top for scope
  def deal_a_card(new_deck,current_card)
    current_card << new_deck.pop
  end


  def game_summary(house_hand, player_hand,card_suit_names,card_values,player_stands,house_stands,winner)

    player_hand_cards = player_hand.map {|c| c[0]}
    player_hand_suit = player_hand.map  {|s| s[1] }
    player_has_ace = false
    house_has_ace = false

    # Player summary
    player_total = 0
    puts "You have the following hand:"
    puts "============================"
    player_hand.each do
      |e| puts "#{e[0]} of #{card_suit_names.fetch(e[1])}"
        if e[0] == "A"
          player_has_ace = true
        end
      hash_value = card_values.fetch(e[0])
      player_total += hash_value
    end

    # Ace/Bust adjustment:
   if player_total >= BUST && player_has_ace
      player_total -= 11
    end
    winner[1] = player_total
    puts "For a total of #{player_total}."

    if player_stands == true
      puts "You have chosen to STAND."
    end

    # House summary
    house_total = 0
    puts ""
    puts "The house has the following hand:"
    puts "================================="
    house_hand.each do
    |e| puts "#{e[0]} of #{card_suit_names.fetch(e[1])}"
      if e[0] == "A"
         house_has_ace = true
      end
      hash_value = card_values.fetch(e[0])
      house_total += hash_value
    end

    # Ace/Bust adjustment:
     if house_total >= BUST && house_has_ace
      house_total -= 11
     end
     winner[2] = house_total
     puts "For a total of #{house_total}."
     puts ""

    # Win checks:
    if  house_total == 21 && player_total == 21
      puts "We have a PUSH, no one wins!"
      winner[0] = true
    elsif
      house_total >= BUST and player_total >= BUST
      puts "We have a PUSH, no one wins!"
      winner[0] = true
    elsif
      player_total == BLACKJACK
      puts "Player wins! Blackjack!"
      winner[0] = true
    elsif
      house_total == BLACKJACK
      puts "The house wins! Blackjack!"
      winner[0] = true
    elsif
      player_total >= BUST
      puts "You busted! House wins."
      winner[0] = true
    elsif
      house_total >= BUST
      puts "House went bust! You win."
      winner[0] = true
    elsif
      player_stands == true && house_total > player_total
      puts "The house has won with #{house_total}!"
      winner[0] = true
    end


  end   # method end

# end methods



  # Initial game prompt and instructions:
  puts "Hello and welcome to ruby Blackjack."
  puts ""
  puts "Here is a recap of the rules before we begin."
  puts RULES
  puts ""
  puts "Press enter to begin."
  player_name = gets.chomp
    if player_name == ""
       player_name == "Player"
    end

  # Begin game by dealing 2 cards to each player:
  current_card = []
  current_card = deal_a_card(new_deck, current_card)
  player_hand << current_card.pop
  current_card = deal_a_card(new_deck, current_card)
  player_hand << current_card.pop
  current_card = deal_a_card(new_deck, current_card)
  house_hand << current_card.pop
  current_card= deal_a_card(new_deck, current_card)
  house_hand << current_card.pop


# Main logic begin:


winner[0] = false
while winner[0] == false

# Display game summary each iteration:
  game_summary(house_hand, player_hand,card_suit_names,card_values,player_stands,house_stands,winner)

if winner[0]== false

   if player_stands == true
   else
     puts "Would you like to Hit(another card) or Stand? .. enter an 'H' to Hit..'S' to stand...you can also Quit with 'Q'."
     user_response = gets.chomp.downcase

     if user_response == HIT
       current_card = []
       current_card = deal_a_card(new_deck, current_card)
       player_hand << current_card.pop
     elsif user_response == STAND
           puts "You have chosen to Stand."
           player_stands = true
     elsif user_response == QUIT
      stop = true
     end

   end

end


# House turn:
  if winner[0] == false  && winner[2] <= 19
    current_card = []
    current_card = deal_a_card(new_deck, current_card)
    house_hand << current_card.pop
  end


end # main end

puts "Goodbye and thanks for playing."

