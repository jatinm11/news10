//
//  splashViewController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 09/10/17.
//  Copyright © 2017 Jatin Menghani. All rights reserved.
//

import UIKit

class splashViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        SourceNewsController.getNews { (success) in
            if success {
                self.performSegue(withIdentifier: "toMainVC", sender: nil)
                self.activityIndicator.stopAnimating()
                sourceNewsControllerTwo.country = "usa"
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
