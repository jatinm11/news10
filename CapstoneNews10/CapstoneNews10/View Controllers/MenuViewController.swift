//
//  MenuViewController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 27/01/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var textChanged: Bool = false
    
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func changeText() {
        savedButton.setTitle("MADE WITH LOVE ❤️", for: .normal)
        aboutButton.setTitle("IN RAIPUR", for: .normal)
        contactButton.setTitle("CREDITS TO NEWSAPI.ORG", for: .normal)
        
        aboutButton.isEnabled = false
        savedButton.isEnabled = false
        contactButton.isEnabled = false
        
        textChanged = true
    }
    
    @IBAction func unwindSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "unwind", sender: self)
    }
    
    func changeTextBack() {
        aboutButton.setTitle("ABOUT", for: .normal)
        savedButton.setTitle("SAVED", for: .normal)
        contactButton.setTitle("CONTACT", for: .normal)
        
        aboutButton.isEnabled = true
        savedButton.isEnabled = true
        contactButton.isEnabled = true

        
        textChanged = false
    }
    
    // No copyright infringement intended
    
    @IBAction func aboutButtonTapped(_ sender: Any) {
        changeText()
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        if textChanged {
            changeTextBack()
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func dismissAreaTapped(_ sender: Any) {
        if textChanged {
            changeTextBack()
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func contactButtonTapped(_ sender: Any) {
        guard let url = URL(string: "http://jatinmenghani.com/#contact") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
