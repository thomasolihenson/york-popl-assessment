#lang racket

; INTRO TEXT

(display "Hello and welcome to CLOSURE game!!\n\nDESCRIPTION OF THE GAME!!!\nGame Machine will ask a player to make a deposit (minimum of 2 pounds and a maximum of 30\npounds).\n")
(display "The amount of money the player gave will be treated as his number which is required to play in the\ngame.\nNext, Game Machine will generate a random number and compare it with the player's number.\n")
(display "If the player's number is less than or equal to the random number, then player loses.\nIf the player's number is greater than the random number, then player wins.\n\n")
(display "If the player wins, then he scores 1 point [Game Machine will increase player's account (number) by\n1 pound, and deduct 2 pounds from its account].\n")
(display "If the player loses, then he will lose 2 points [Game Machine will deduct 2 pounds from player's\naccount(number), and add 1 pound in its account].\n")
(display "During the game, if the player doesn't have any credit, then the game ends. The player can start a\nnew game by re-register with a deposit.\n")

; MAIN DEFINITIONS

(define game_machine_amount 10)

(define (game_machine_decrement)
  (display (~a "Game Machine, before you had: " game_machine_amount " pound(s)\n"))
  (set! game_machine_amount (- game_machine_amount 2))
  (display (~a "You now have: " game_machine_amount " pound(s)\n"))
  (if (> game_machine_amount 1)
      (display "Game Machine, there is still enough money in the machine for a game to be played\n")
      (display ". . Game Machine, there isn't any credit in the machine for a game to be played, needs to top up\n")))

(define (game_machine_increment)
  (display (~a "Game Machine, before you had: " game_machine_amount " pound(s)\n"))
  (set! game_machine_amount (+ game_machine_amount 1))
  (display (~a "You now have: " game_machine_amount " pound(s)\n")))

(define (a-game number)
  (if (or (< number 2) (> number 30))
      (display (~a "Game Player, you decide to go with number: " number ". . Wrong, number/amount should be a minimum of 2 pounds and a maximum of 30 pounds\n"))
      (begin
        (display (~a "Game Player, you decide to go with number: " number))
        (display "\nGREAT!!!\nRemember, in the game, if the player wins, then he scores\n1 point [Game Machine will increase player's\naccount(number) by 1 pound, and deduct 2 pounds from its\naccount].\n")
        (display "If the player loses, then he will lose 2 points [Game\nMachine will deduct 2 pounds from player's\naccount(number), and add 1 pound in its account].\n")
        (display "During the game, if the player doesn’t have any credit,\nthen the game ends. The player can start a new game by\nre-register with a deposit.\n")
        (display "Generating a random number is now requested. Game Machine\nis about to generate a random number and compare it with\nthe player's number.\n")
        )
      )
  (define (the-game-number)

    ; RANDOMNUM

    (define (randomnum)
      (lambda (random)
        (define randomvalue (random 2 51))
        (display (~a "The random number is: " randomvalue "\nGame Player, your number is:" number "\nIf your number is less than or equal the random number, you lose, otherwise you win.\n"))
        (if (<= number randomvalue)
            (begin
              (display "Unfortunately, you have lost, Game Machine will deduct 2 pounds from your account.\n")
              ; The below function could be called to decrease the players money, however I could not
              ; tell whether you wanted this included or not
              ; ((decreasemoney))
              )
            (begin
              (display "Great, you have won, Game Machine will add one pound in your account.\n")
              ; The below function could be called to increase the players money, however I could not
              ; tell whether you wanted this included or not
              ; ((increasemoney))
              ))))

    ; INCREASE MONEY

    (define (increasemoney)
      (lambda ()
        (display (~a "Game Player, previously you had:" number " pound(s)\nYou have scored 1 point, and been awarded 1 pound by the Game Machine!\n"))
        (set! number (+ number 1))
        (display (~a "You now have:" number " pound(s)\n"))))

    ; DECREASED MONEY

    (define (decreasemoney)
      (lambda ()
        (display (~a "Game Player, previously you had:" number " pound(s)\nYou have lost, Game Machine is deducting 2 pounds from your account!\n"))
        (set! number (- number 2))
        (display (~a "You now have:" number " pound(s)\n"))
        (if (> number 1)
            (display "You still have enough credit to play.\n")
            (display ". . Sorry, you are out of credit, which you can't \ncontinue to play. To continue playing, you need to top-\nup.\nSee you soon!!!\n"))))

    ; TOPUP

    (define (topup)
      (lambda (t)
        (display (~a "Game Player, you just topped up: " t " pound(s)\n"))
        (if (or (< t 2) (> t 30))
            (display ". . Wrong,number/amount should be a minimum of 2 pounds \nand a maximum of 30 pounds\n")
            (begin
              (display "\"Great, you can play now\"\n")
              (set! number (+ number t))))))

    ; ERROR

    (define (error errorname)
      (lambda ((errors "blank")) ; sets errors to blank if no parameter is given
        (display (~a ". . unknown request " errorname "\n"))))

    ; REQUESTS FROM THE-GAME-NUMBER

    (lambda (request)
      (cond
        ((eqv? request 'randomnum)
         (randomnum))
        ((eqv? request 'increasemoney)
         (increasemoney))
        ((eqv? request 'decreasemoney)
         (decreasemoney))
        ((eqv? request 'topup)
         (topup))
        (else (error request)))))
  (the-game-number))
