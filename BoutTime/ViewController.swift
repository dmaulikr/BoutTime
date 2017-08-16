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
    @IBOutlet weak var MoveUpFullButton: UIButton!
    // Next round button
    @IBOutlet weak var nextRoundButton: UIButton!
    // Tap events label
    @IBOutlet weak var tapEventsLabel: UILabel!
    
    
    // MARK: - Setup
    let round: Round
    
    required init?(coder aDecoder: NSCoder) {
        do {
            let array = try PListConverter.array(fromFile: "EventList", ofType: "plist")
            let events = try EventListUnarchiver.eventList(fromArray: array)
            self.round = Round(events: events)
        } catch let error {
            fatalError("\(error)")
        }
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEventViews()
        disableEventButtons()
        nextRoundButton.isHidden = true
        tapEventsLabel.isHidden = true
    }
    
    func disableEventButtons() {
        eventButtonOne.isEnabled = false
        eventButtonTwo.isEnabled = false
        eventButtonThree.isEnabled = false
        eventButtonFour.isEnabled = false
    }

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
    
    func disableMoveButtons() {
        moveDownFullButton.isEnabled = false
        moveUpHalfButtonOne.isEnabled = false
        moveDownHalfButtonOne.isEnabled = false
        moveUpHalfButtonTwo.isEnabled = false
        moveDownHalfButtonTwo.isEnabled = false
        MoveUpFullButton.isEnabled = false
    }
}

