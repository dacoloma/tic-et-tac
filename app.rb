require 'pry'
class BoardCase
    attr_accessor :etat

    #La case doit être vide à l'init
    def initialize
        @etat = " "

    end

end

class Board

    attr_accessor :tab
    attr_reader :error, :win

    #Booléen i qui détermine si la case à remplir doit avoir un X ou un O
    @@i = true


    #accueille les 9 cases
    def initialize

        @case1 = BoardCase.new
        @case2 = BoardCase.new
        @case3 = BoardCase.new
        @case4 = BoardCase.new
        @case5 = BoardCase.new
        @case6 = BoardCase.new
        @case7 = BoardCase.new
        @case8 = BoardCase.new
        @case9 = BoardCase.new

        @tab = [@case1.etat,@case2.etat,@case3.etat,@case4.etat,@case5.etat,@case6.etat,@case7.etat,@case8.etat,@case9.etat]
    end

    #Affiche l'état de ma grille
    def state
        system 'clear'
        print "\t\t" * 3
        puts @tab[0..2].join(" | ")
        print "\t\t" * 3
        puts "——+———+——"
        print "\t\t" * 3
        puts @tab[3..5].join(" | ")
        print "\t\t" * 3
        puts "——+———+——"
        print "\t\t" * 3
        puts @tab[6..8].join(" | ")

    end

    def plays

        @error = false
        @move = gets.chomp

        #Renvoie un msg erreur si le joueur veut taper n'importe nawak
        if "123456789".include? @move
            @move = @move.to_i
            if @tab[@move - 1] == " "
                if @@i == true
                    @tab[@move - 1] = 'X'
                    @@i = !@@i
                else
                    @tab[@move - 1] = 'O'
                    @@i = !@@i
                end

                @error = false
            else
                @error = true
            end

        else
            @error = true
        end
    end

    def victory
        @win = false

        #Verticales
        @win =  true if @tab[0] == @tab[3] && @tab[3] == @tab[6] && @tab[0] != " "
        @win =  true if @tab[1] == @tab[4] && @tab[4] == @tab[7] && @tab[1] != " "
        @win =  true if @tab[2] == @tab[5] && @tab[5] == @tab[8] && @tab[2] != " "

        #Horizontales
        @win =  true if @tab[0] == @tab[1] && @tab[1] == @tab[2] && @tab[0] != " "
        @win =  true if @tab[3] == @tab[4] && @tab[4] == @tab[5] && @tab[3] != " "
        @win =  true if @tab[6] == @tab[7] && @tab[7] == @tab[8] && @tab[6] != " "

        #Diagonales
        @win =  true if @tab[0] == @tab[4] && @tab[4] == @tab[8] && @tab[0] != " "
        @win =  true if @tab[2] == @tab[4] && @tab[4] == @tab[6] && @tab[2] != " "

    end
end

class Player
    #nom
    attr_accessor :name
end

class Game
    @@turn = false

    def initialize
        #Création de mes 2 joueurs
        @player1 = Player.new
        @player2 = Player.new

        #Initialise de Board
        @board = Board.new

        #Naming joueurs
        print "Enter name Player1 : "
        @player1.name = gets.chomp
        print "Enter name Player2 : "
        @player2.name = gets.chomp

        #efface la console
        system "clear"

        #Présentation
        print "\t" * 3
        puts "Welcome #{@player1.name} & #{@player2.name} !!! Let's play a game..."
        print "\t" * 5
        3.times{
            print "."
            sleep(1)
        }
        puts "\n\n\t\t#{@player1.name}, you'll play with the 'X'  &  #{@player2.name}, you'll play with the 'O'"
        print "\t" * 5
        3.times{
            print "."
            sleep(1)
        }

        puts"\n\n\n\t\t J'espère que vous avez lu le README. Are you ready ? (press Enter)"
        print "\t " * 5
        gets.chomp
    end

    def play
        #affiche le plateau de jeu
        @board.state

        while (@board.tab.include? " ")
            #On alterne les tours avec un booléen
            @@turn = !@@turn
            if @@turn == true
                player = @player1
            else
                player = @player2
            end
            print "\t\t\t  #{player.name}, your move (1-9): "

            #Le joueur effectue son choix
            @board.plays

            #Si error = true on rentre dans une boucle pour lui dire de reessayer
            while @board.error
                @board.state
                puts "\t\t\t  ERROR, try again"
                print "\t\t\t  #{player.name}, your move (1-9): "
                @board.plays
            end

            #Après une action d'un joueur, on raffiche le plateau
            @board.state

            #On teste si il y a une victoire
            @board.victory
            break if @board.win == true
            
        end
        if @board.win == true
            puts "\t\tWE HAVE A WINNER ! CONGRATULATIONS #{player.name} ! Le loser te doit une pinte !"
        else
            puts "\t\t\t\t\t\t  TIE GAME. Offrez vous des pintes mutuellement."
        end
    end

end

tic_tac = Game.new

tic_tac.play
