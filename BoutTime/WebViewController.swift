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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        if let url = URL(string: "https://google.co.uk") {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
    // Hide status bar for web view
    override var prefersStatusBarHidden: Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
