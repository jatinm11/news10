//
//  NewsSavedViewController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 23/01/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class NewsSavedViewController: UIViewController {

    @IBOutlet weak var newsSavedViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        newsSavedViewContainer.layer.cornerRadius = 5
//        newsSavedViewContainer.clipsToBounds = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBAction func dismissTapGesture(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DismissGestureTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
