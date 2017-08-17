//
//  ScoreViewController.swift
//  BoutTime
//
//  Created by James Mulholland on 17/08/2017.
//  Copyright © 2017 JamesMulholland. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(score)/6"
    }
}
