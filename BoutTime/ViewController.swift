//
//  ViewController.swift
//  BoutTime
//
//  Created by James Mulholland on 15/08/2017.
//  Copyright © 2017 JamesMulholland. All rights reserved.
//

import UIKit

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
    // Tap events label
    @IBOutlet weak var tapEventsLabel: UILabel!
    
    
    // MARK: - Setup
    var round: Round
    
    required init?(coder aDecoder: NSCoder) {
        self.round = Round()
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
        if round.checkAnswers() {
            // print("Right!")
            nextRoundButton.setImage(#imageLiteral(resourceName: "next_round_success"), for: .normal)
        } else {
            // print("wrong!")
            nextRoundButton.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
        }
        enableEventButtons()
        disableMoveButtons()
        nextRoundButton.isHidden = false
        tapEventsLabel.isHidden = false
    }
    
    func newRound() {
        round = Round()
        disableEventButtons()
        enableMoveButtons()
        nextRoundButton.isHidden = true
        tapEventsLabel.isHidden = true
        loadEventsToButtons()
    }
    
    @IBAction func nextRoundWasTapped(_ sender: Any) {
        newRound()
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
    
    @IBAction func unwindToGame(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var urlString = "https://facebook.com"
        if let senderButton = sender as? UIButton {
            if senderButton == eventButtonOne {
                urlString = round.events[0].url
            } else if senderButton == eventButtonTwo {
                urlString = round.events[1].url
            } else if senderButton == eventButtonThree {
                urlString = round.events[2].url
            } else if senderButton == eventButtonFour {
                urlString = round.events[3].url
            } else {
                print("ERROR - Invalid button")
            }
        }

        let webViewController = segue.destination as? WebViewController
        webViewController?.urlString = urlString
    }
    
    @IBAction func eventButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "Web", sender: sender)
    }
}


//    func loadNextRoundWithDelay(seconds: Int) {
//        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
//        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
//        // Calculates a time value to execute the method given current time and delay
//        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
//
//        // Executes the nextRound method at the dispatch time on the main queue
//        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
//            self.newRound()
//        }
//    }


