//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit


class HangmanViewController: UIViewController {
    
    let hangmanPhrases = HangmanPhrases()
    // Generate a random phrase for the user to guess
    var phrase: String = ""
    var charactersString = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersString = []
        phrase = ""
        phrase = hangmanPhrases.getRandomPhrase()
                print(phrase)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HangmanViewController.dismissKeyboard)) //see function below
        
        view.addGestureRecognizer(tap)
        
        for char in Array(phrase.characters) {
            charactersString.append(String(char))
        }
        
        dashesDisplay()
        imageDisplayFunc()
    }

    //To close keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
   
    @IBOutlet weak var imageDisplay: UIImageView!
    var incorrectGuesses = 0 //max 6 allowed, with each incorrect guess, picture needs to update
    
    //this needs to be printed next to incorrect guesses on view
    var incorrectGuessList = [String]()
    
   
    @IBOutlet weak var incorrect: UILabel!
    
    //this value needs to come from user
    @IBOutlet weak var input: UITextField!
    
    

    var lettersGuessed: Array = [" "]
    var dashesString = ""
    var guess: String! = ""
    
    
    
    //the dashes line
    @IBOutlet weak var dashes: UILabel!
    func dashesDisplay() -> String{
        dashesString = ""
        for i in 0...charactersString.count-1 {
            if lettersGuessed.contains(String(charactersString[i])){
                dashesString += String(charactersString[i])
            }else {dashesString += "-"
        }
        }
        dashes.text = dashesString
        return dashesString
    }
    
    //updates incorrect guess list and count, check if 6 incorrect reached
    func trackIncorrect(){
        guess = String(describing: self.input.text!)
        guess = guess.uppercased()
        lettersGuessed.append(guess)
        if charactersString.contains(guess)==false{
            if incorrectGuessList.contains(guess)==false{
                incorrectGuesses += 1
                incorrectGuessList.append(guess)
            }
        }
        //alert if game lost
        if incorrectGuesses >= 6{
            lettersGuessed = charactersString
            dashesDisplay()
            let alert = UIAlertView(title: "Game Over", message:"Try again...", delegate: nil, cancelButtonTitle: "Cancel")
            
            alert.show()
        }
        var incorrectString = incorrectGuessList.joined(separator: ",")
        incorrect.text = incorrectString
    }

    
    //change image based on number wrong
    func imageDisplayFunc(){
        if incorrectGuesses==0{
            imageDisplay.image = UIImage(named: "hangman1.png")}
        if incorrectGuesses==1{
            imageDisplay.image = UIImage(named: "hangman2.png")}
        if incorrectGuesses==2{
            imageDisplay.image = UIImage(named: "hangman3.png")}
        if incorrectGuesses==3{
            imageDisplay.image = UIImage(named: "hangman4.png")}
        if incorrectGuesses==4{
            imageDisplay.image = UIImage(named: "hangman5.png")}
        if incorrectGuesses==5{
            imageDisplay.image = UIImage(named: "hangman6.png")}
        if incorrectGuesses==6{
            imageDisplay.image = UIImage(named: "hangman7.png")}
        
    }
//Guess button pressed, check correctness, call necessary functions
    @IBAction func Guess(_ sender: UIButton) {
        if input.text == ""{
            return
        }
        var length = String(describing: self.input.text!)
            if (length.characters.count) > 1{
                let alert2 = UIAlertView(title: "OOPS!", message:"Enter one letter only!", delegate: nil, cancelButtonTitle: "Cancel")
                alert2.show()
                input.text = ""
                return
            } else {
            trackIncorrect()
            imageDisplayFunc()
            input.text = ""
            dashesDisplay()
            for i in charactersString{
                if lettersGuessed.contains(i)==false{
                    return
                }
            }//alert if game won
                if incorrectGuesses < 6{
                    let alert1 = UIAlertView(title: "You Won!", message:"Play Again!", delegate: nil, cancelButtonTitle: "Cancel")
                
                alert1.show()
                return
                }
        }
    }
//Start Over button pressed, reset values
    @IBAction func startGame(_ sender: UIButton) {
        incorrectGuessList = []
        incorrect.text = ""
        incorrectGuesses = 0
        dashes.text = ""
        viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
