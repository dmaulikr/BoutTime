//
//  ViewController.swift
//  BoutTime
//
//  Created by James Mulholland on 15/08/2017.
//  Copyright © 2017 JamesMulholland. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    // MARK: - Outlets
    // Event views
    @IBOutlet weak var eventViewOne: UIView!
    @IBOutlet weak var eventViewTwo: UIView!
    @IBOutlet weak var eventViewThree: UIView!
    @IBOutlet weak var eventViewFour: UIView!
    // Event buttons
    @IBOutlet weak var eventButtonOne: UIButton!
    @IBOutlet weak var eventButtonTwo: UIButton!
    @IBOutlet weak var eventButtonThree: UIButton!
    @IBOutlet weak var eventButtonFour: UIButton!
    // Move buttons
    @IBOutlet weak var moveDownFullButton: UIButton!
    @IBOutlet weak var moveUpHalfButtonOne: UIButton!
    @IBOutlet weak var moveDownHalfButtonOne: UIButton!
    @IBOutlet weak var moveUpHalfButtonTwo: UIButton!
    @IBOutlet weak var moveDownHalfButtonTwo: UIButton!
    @IBOutlet weak var moveUpFullButton: UIButton!
    // Next round button
    @IBOutlet weak var nextRoundButton: UIButton!
    // Information label
    @IBOutlet weak var informationLabel: UILabel!
    // Timer Label
    @IBOutlet weak var timerLabel: UILabel!
    
    // MARK: - Setup
    // Game information
    var numberOfRounds: Int = 0
    var correctAnswers: Int = 0
    var round: Round
    
    // Sounds
    var soundProvider = SoundProvider()
    
    // Timer
    var timer = Timer()
    let timerLength = 60.0
    var timeRemaining: Double
    
    required init?(coder aDecoder: NSCoder) {
        self.round = Round()
        self.timeRemaining = timerLength
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Become first responder for shake events
        self.becomeFirstResponder()
        
        // configure event views' appearance
        configureEventViews()
        
        // load first round
        newRound()
    }
    
    
    // MARK: - Main game logic
    
    func endRound() {
        if numberOfRounds >= 6 {
            nextRoundButton.setImage(#imageLiteral(resourceName: "show_score_button"), for: .normal)
        } else {
            if round.checkAnswers() {
                correctAnswers += 1
                soundProvider.playCorrectSound()
                nextRoundButton.setImage(#imageLiteral(resourceName: "next_round_success"), for: .normal)
            } else {
                soundProvider.playIncorrectSound()
                nextRoundButton.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
            }
        }
        timer.invalidate()
        timerLabel.isHidden = true
        enableEventButtons()
        disableMoveButtons()
        nextRoundButton.isHidden = false
        informationLabel.text = "Tap events to learn more"
    }
    
    func newRound() {
        timeRemaining = timerLength
        timerLabel.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        
        round = Round()
        numberOfRounds += 1
        disableEventButtons()
        enableMoveButtons()
        nextRoundButton.isHidden = true
        
        informationLabel.text = "Shake to complete"
        loadEventsToButtons()
    }
    
    func newGame() {
        numberOfRounds = 0
        correctAnswers = 0
        newRound()
    }
    
    @IBAction func nextRoundWasTapped(_ sender: Any) {
        // If 6 rounds are completed then show score screen
        if numberOfRounds >= 6 {
            performSegue(withIdentifier: "Score", sender: sender)
        } else {
            newRound()
        }
    }
    
    @IBAction func moveButtonWasTapped(_ sender: UIButton) {
        if sender == moveDownFullButton || sender == moveUpHalfButtonOne {
            swapWithEventBelow(eventIndex: 0)
        } else if sender == moveDownHalfButtonOne || sender == moveUpHalfButtonTwo {
            swapWithEventBelow(eventIndex: 1)
        } else if sender == moveDownHalfButtonTwo || sender == moveUpFullButton {
            swapWithEventBelow(eventIndex: 2)
        } else {
            print("ERROR - invalid button")
        }
    }

    func swapWithEventBelow(eventIndex: Int) {
        // Set placeholder events
        let eventOne = round.events[eventIndex]
        let eventTwo = round.events[eventIndex+1]
        
        // Reassign events back in events array
        round.events[eventIndex] = eventTwo
        round.events[eventIndex+1] = eventOne
        
        // Refresh text on buttons
        loadEventsToButtons()
    }
    
    
    // MARK: - Shake Functionality
    
    // Enable ViewController as first responder
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Trigger events upon shaking
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            endRound()
        }
    }
    
    // MARK: - Timer
    @objc
    func updateTimer() {
        // Updates the timer and the timer text (information) label
        if timeRemaining < 0.01 {
            timer.invalidate()
            endRound()
        } else {
            timeRemaining -= 0.01
        }
        let formatedTimer = String(format: "%.2f", timeRemaining)
        timerLabel.text = formatedTimer
    }
    
    func resetTimer() {
        timer = Timer()
        timeRemaining = timerLength
    }
    
    
    // MARK: - Visual configuration

    func configureEventViews() {
        eventViewOne.layer.cornerRadius = 5
        eventViewOne.layer.masksToBounds = true
        eventViewTwo.layer.cornerRadius = 5
        eventViewTwo.layer.masksToBounds = true
        eventViewThree.layer.cornerRadius = 5
        eventViewThree.layer.masksToBounds = true
        eventViewFour.layer.cornerRadius = 5
        eventViewFour.layer.masksToBounds = true
    }
    
    func enableEventButtons() {
        eventButtonOne.isEnabled = true
        eventButtonTwo.isEnabled = true
        eventButtonThree.isEnabled = true
        eventButtonFour.isEnabled = true
    }
    
    func disableEventButtons() {
        eventButtonOne.isEnabled = false
        eventButtonTwo.isEnabled = false
        eventButtonThree.isEnabled = false
        eventButtonFour.isEnabled = false
    }
    
    func enableMoveButtons() {
        moveDownFullButton.isEnabled = true
        moveUpHalfButtonOne.isEnabled = true
        moveDownHalfButtonOne.isEnabled = true
        moveUpHalfButtonTwo.isEnabled = true
        moveDownHalfButtonTwo.isEnabled = true
        moveUpFullButton.isEnabled = true
    }
    
    func disableMoveButtons() {
        moveDownFullButton.isEnabled = false
        moveUpHalfButtonOne.isEnabled = false
        moveDownHalfButtonOne.isEnabled = false
        moveUpHalfButtonTwo.isEnabled = false
        moveDownHalfButtonTwo.isEnabled = false
        moveUpFullButton.isEnabled = false
    }
    
    func loadEventsToButtons() {
        eventButtonOne.setTitle(round.events[0].description, for: .normal)
        eventButtonTwo.setTitle(round.events[1].description, for: .normal)
        eventButtonThree.setTitle(round.events[2].description, for: .normal)
        eventButtonFour.setTitle(round.events[3].description, for: .normal)
    }
    
    // MARK: - Navigation
    
    // Start new game if returning from score screen
    @IBAction func unwindToGame(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "PlayAgain" {
            newGame()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var urlString = "https://facebook.com"
        if let senderButton = sender as? UIButton {
            // If Score segue is used, load score onto label.
            if senderButton == nextRoundButton {
                let scoreViewController = segue.destination as? ScoreViewController
                scoreViewController?.score = correctAnswers
            } else {
                // Launch appropriate webView for each event button
                if senderButton == eventButtonOne {
                    urlString = round.events[0].url
                } else if senderButton == eventButtonTwo {
                    urlString = round.events[1].url
                } else if senderButton == eventButtonThree {
                    urlString = round.events[2].url
                } else if senderButton == eventButtonFour {
                    urlString = round.events[3].url
                }
                let webViewController = segue.destination as? WebViewController
                webViewController?.urlString = urlString
            }
        }
    }
    
    @IBAction func eventButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "Web", sender: sender)
    }
}



