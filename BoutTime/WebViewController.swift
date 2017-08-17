//
//  WebViewController.swift
//  BoutTime
//
//  Created by James Mulholland on 17/08/2017.
//  Copyright © 2017 JamesMulholland. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    // default URL value
    var urlString: String = "https://google.co.uk"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
    // Hide status bar for web view
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
