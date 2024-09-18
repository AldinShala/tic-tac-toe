import UIKit

class ViewController: UIViewController {

@IBOutlet var buttons: [UIButton]!      // Collection for all the buttons representing the Tic-Tac-Toe board
var currentPlayer = ""                  // Variable to track the current player ("X" or "O")
var board = [String]()                  // Array representing the game board, where each element holds "X", "O", or is empty
var rules = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]   // Winning combinations for the game

override func viewDidLoad() {              // Called when the view is loaded into memory
    super.viewDidLoad()
    loadBoard()                            // Initialize the board with empty values
}

@IBAction func buttonPressed(_ sender: UIButton) {      // Action triggered when a button is pressed (player's move)
    let index = buttons.index(of: sender)!              // Get the index of the button pressed from the buttons array
    
    if !board[index].isEmpty {                          // Check if the current button has already been played (not empty)
        return                                          // If the button is already filled, exit the function
    }
    
    if currentPlayer == "X" {                 // Update the button's title and board based on the current player
        sender.setTitle("X", for: .normal)    // Set button title to "X"
        currentPlayer = "O"                   // Switch to player "O"
        board[index] = "X"                    // Mark the board with "X"
    } else {
        sender.setTitle("O", for: .normal)    // Set button title to "O"
        currentPlayer = "X"                   // Switch to player "X"
        board[index] = "O"                    // Mark the board with "O"
    }
    whoWins()                                 // Check if someone has won or if the game is a tie
}

func whoWins() {                              // Function to check if a player has won the game
    for rule in rules {                       // Loop through each winning combination (rules)
        let player1 = board[rule[0]]
        let player2 = board[rule[1]]
        let player3 = board[rule[2]]
        // Check if all positions in the rule have the same player ("X" or "O") and are not empty
        if player1 == player2, player2 == player3, !player1.isEmpty {
            print("Winner is \(player2)")
            showAlert(msg: "Good job \(player3) You have won ")
            return                           // Exit the function if a winner is found
        }
    }
    if !board.contains("") {                 // If the board is full and no one has won, it's a tie
        showAlert(msg: "It is a tie!")
    }
}

    // Function to display an alert with a custom message
func showAlert(msg : String) {
    let alert = UIAlertController(title: "Success", message: msg, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default) {
        _ in self.reset()          // Create an action (OK button) that will reset the game
    }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
}

func reset() {                    // Function to reset the game after a win or tie
    board.removeAll()             // Clear the board array
    loadBoard()                   // Initialize the board with empty strings
    
    for button in buttons {       // Clear the buttons (set them back to empty)
        button.setTitle("", for: .normal)
    }
    
}

func loadBoard(){                    // Function to initialize the board with empty strings
    for _ in 0..<buttons.count {     // Fill the board array with empty strings (one for each button)
        board.append("")
        
    }
    
}
}
