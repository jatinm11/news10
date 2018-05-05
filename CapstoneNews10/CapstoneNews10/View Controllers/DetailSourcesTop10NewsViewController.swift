//
//  DetailSourcesTop10NewsViewController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 09/10/17.
//  Copyright © 2017 Jatin Menghani. All rights reserved.
//

import UIKit

class DetailSourcesTop10NewsViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var headlineViewContainer: UIView!
    @IBOutlet var fullStoryButton: UIButton!
    
    let colorProvider = BackgroundColorProvider()
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let randomColor = colorProvider.randomColor()
        self.view.backgroundColor = randomColor
        fullStoryButton.setTitleColor(randomColor, for: .normal)
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        imageView.image = sourceNewsControllerTwo.news[index].poster
        titleLabel.text = sourceNewsControllerTwo.news[index].title
        descriptionLabel.text = sourceNewsControllerTwo.news[index].description

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descriptionLabel.sizeToFit()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBAction func dismissSwipeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissSwipeActionTwo(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func fullStoryButtonTapped(_ sender: Any) {
        guard let url = URL(string: sourceNewsControllerTwo.news[index].url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    @IBAction func shareButtonTapped(_ sender: Any) {
        
        let text = "Hey, Check this news out..."
        let url = sourceNewsControllerTwo.news[index].url
        guard let newsURL = NSURL(string: url) else { return }
        let objectsToShare = [text, newsURL] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.openInIBooks, UIActivityType("com.apple.reminders.RemindersEditorExtension")]
        activityVC.popoverPresentationController?.sourceView = sender as? UIView
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
