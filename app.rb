require 'pry'
class BoardCase
    attr_accessor :etat
    attr_reader :number
    #initialisation : doit être vide
    def initialize(number)
        @etat = " "
        @number=number
    end

end

class Board
    #accueille les 9 cases
    attr_accessor :tab
    attr_reader :error, :win
    @@i = true

    def initialize

        @case1 = BoardCase.new(1)
        @case2 = BoardCase.new(2)
        @case3 = BoardCase.new(3)
        @case4 = BoardCase.new(4)
        @case5 = BoardCase.new(5)
        @case6 = BoardCase.new(6)
        @case7 = BoardCase.new(7)
        @case8 = BoardCase.new(8)
        @case9 = BoardCase.new(9)
        @case1.etat = 'X'
        @case5.etat = 'X'

        @tab = [@case1.etat,@case2.etat,@case3.etat,@case4.etat,@case5.etat,@case6.etat,@case7.etat,@case8.etat,@case9.etat]
    end

    def state
        system 'clear'
        print "\t\t" * 3
        puts @tab[0..2].join(" | ")#.map{|c| c.etat}.join(" | ")
        print "\t\t" * 3
        puts "——+———+——"
        print "\t\t" * 3
        puts @tab[3..5].join(" | ")#.map{|c| c.etat}.join(" | ")
        print "\t\t" * 3
        puts "——+———+——"
        print "\t\t" * 3
        puts @tab[6..8].join(" | ")#.map{|c| c.etat}.join(" | ")

    end

    def plays
        @error = false
        @move = gets.chomp.to_i
        if @tab[@move - 1] == " " #.etat == " "
            if @@i == true
                @tab[@move - 1] = 'X'#.etat = 'X'
                @@i = !@@i

            else
                @tab[@move - 1] = 'O' #.etat = 'O'
                @@i = !@@i
            end
            @error = false

        else
            @error = true
            #binding.pry
        end

    end

    def victory
        @win = false

        case @tab[0]
        when @tab[1]
            if @tab[0] == @tab[2]
                @win =  true
                binding.pry
            end
        when @tab[4]
            if @tab[0] == @tab[8]
                @win =  true
            end
        when @tab[3]
            if @tab[0] == @tab[6]
                @win =  true
            end
        end

        case @tab[2]
        when @tab[4]
            if @tab[2] == @tab[6]
                @win =  true
            end
        when @tab[5]
            if @tab[2] == @tab[8]
                @win =  true
            end
        end

        @win =  true if @tab[3] == @tab[4] && @tab[3] == @tab[5]

        @win =  true if @tab[1] == @tab[4] && @tab[1] == @tab[7]

        @win =  true if @tab[6] == @tab[7] && @tab[6] == @tab[8]
    end
end

class Player
    #nom
    attr_accessor :name
    #état victoire ou défaite
end

class Game
    @@turn = false
    #Crée 2 joueurs
    def initialize
        @player1 = Player.new
        @player2 = Player.new
        #Initialise de Board
        @board = Board.new
        #print "Enter name Player1 : "
        @player1.name = "J1"#gets.chomp
        print "Enter name Player2 : "
        @player2.name = "J2"#gets.chomp
        system "clear"
        print "\t" * 3
        puts "Welcome #{@player1.name} & #{@player2.name} !!! Let's play a game..."
        print "\t" * 5
        3.times{
            print "."
            #sleep(1)
        }
        puts "\n\n\t\t#{@player1.name}, you'll play with the 'X'  &  #{@player2.name}, you'll play with the 'O'"
        print "\t" * 5
        3.times{
            print "."
            #sleep(1)
        }
        puts"\n\n\n\t\t\t  Are you ready ? (press Enter)"
        print "\t " * 5
        gets.chomp
    end

    def play

        @board.state
        #binding.pry
        while (@board.tab.include? " ")   #break
            @@turn = !@@turn
            if @@turn == true
                player = @player1
            else
                player = @player2
            end
            print "\t\t\t  #{player.name}, your move (1-9): "
            @board.plays
            #binding.pry
            while @board.error
                @board.state
                #binding.pry
                puts "\t\t\t  ERROR, choose an another case"
                print "\t\t\t  #{player.name}, your move (1-9): "
                @board.plays
            end
            @board.state
            @board.victory
            #binding.pry
            break if @board.win == true

        end

        puts "\t\t\t\t\t\t  TIE GAME"
    end

end

tic_tac = Game.new

tic_tac.play
