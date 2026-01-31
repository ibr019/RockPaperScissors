//
//  main.swift
//  Rock_Paper_Scissors
//
//  Created by IT developer on 31.01.2026.
//

import Foundation

enum Elements : String {
    case rock = "rock"
    case paper = "paper"
    case scissors = "scissors"
}

var playerScore = 0
var botScore = 0
var play = "yes"

protocol Player{
    func makeChoice() -> Elements
}

class HumanPlayer : Player {
    func makeChoice() -> Elements {
        print("Your choice (rock, paper, scissors) : " )
        let playerChoice = readLine()?.lowercased() ?? ""
        if let chosenElement = Elements(rawValue: playerChoice) {
            return chosenElement
        } else {
            print("Invalid choice")
            return makeChoice()
        }
    }
}

class BotPlayer : Player {
    func makeChoice() -> Elements {
        let botElements : [Elements] = [.paper, .rock, .scissors]
        return botElements.randomElement()!
    }
}

func playGame(playerOne: Player, playerTwo : Player) {
    while play.lowercased() == "yes" {
        let playerOneChoice = playerOne.makeChoice()
        let playerTwoChoice = playerTwo.makeChoice()
        print(playerTwoChoice)
        switch (playerOneChoice, playerTwoChoice) {
        case (playerOneChoice, playerTwoChoice) where playerOneChoice == playerTwoChoice :
            print("It is a draw")
        case (.rock, .scissors), (.scissors, .paper), (.paper, .rock) :
            print("You win")
            playerScore += 1
        default :
            print("You lose")
            botScore += 1
        }
        print("Player score \(playerScore) - Bot score \(botScore)")
        if playerScore == 3 || botScore == 3 {
            print(playerScore == 3 ? "You won the game" : "You lost the game")
            print("Do you want to play a new game? yes/no")
            if let newGame = readLine()?.lowercased() {
                if newGame == "no" {
                    print("Game was finished")
                }
                play = newGame
            }
            playerScore = 0
            botScore = 0
        }
        
    }
}

playGame(playerOne: HumanPlayer(), playerTwo: BotPlayer())

