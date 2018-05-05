//
//  DeleteNewsConfirmationViewController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 24/01/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class DeleteNewsConfirmationViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    
    var news: SourceNews?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewContainer.layer.cornerRadius = 5
        viewContainer.clipsToBounds = true
        viewContainer.layer.shadowRadius = 5
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        if let news = news {
            sourceNewsControllerTwo.shared.delete(news: news)
            NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}
