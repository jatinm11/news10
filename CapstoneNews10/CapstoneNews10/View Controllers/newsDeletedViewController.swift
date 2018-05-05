//
//  newsDeletedViewController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 01/02/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class newsDeletedViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dismiss(animated: true, completion: nil)
        }
    }
        
    @IBAction func dismissGestureTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissTapGesture(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
