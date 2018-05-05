//
//  SavedNewsViewController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 20/01/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class SavedNewsViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var ni: UINavigationItem!
    @IBOutlet weak var noNewsLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceNewsControllerTwo.shared.load()
        collectionView.delegate = self
        collectionView.dataSource = self
        setNavigationBar()
        
        let shareNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(shareNews))
        shareNavigationButton.tintColor = UIColor.white
        let leftSideButton = [shareNavigationButton]
        self.ni.setLeftBarButtonItems(leftSideButton, animated: true)
        
        let closeNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(dismiss))
        closeNavigationButton.tintColor = UIColor.white
        let deleteNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: self, action: #selector(deleteNews))
        deleteNavigationButton.tintColor = UIColor.white
        let rightSideButtons = [closeNavigationButton,deleteNavigationButton]
        self.ni.setRightBarButtonItems(rightSideButtons, animated: true)
        
        if sourceNewsControllerTwo.shared.savedNews == [] {
            noNewsLabel.isHidden = false
            previousButton.isHidden = true
            nextButton.isHidden = true
            deleteNavigationButton.isEnabled = false
            shareNavigationButton.isEnabled = false
        }
        else {
            for i in sourceNewsControllerTwo.shared.savedNews {
                DispatchQueue.main.async {
                    sourceNewsControllerTwo.fechImage(imageEndPoint: i.posterEndPoint, completion: { (image) in
                        i.poster = image
                    })
                }
                self.collectionView.reloadData()
                self.ni.title = "Saved"
            }
            noNewsLabel.isHidden = true
            previousButton.isHidden = false
            nextButton.isHidden = false
            deleteNavigationButton.isEnabled = true
            shareNavigationButton.isEnabled = true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func loadList(notification: NSNotification) {
        self.collectionView.reloadData()
    }
    
    @objc func shareNews(sender: AnyObject) {
        guard let cell = collectionView.visibleCells.first as? SavedNewsCollectionViewCell,
            let indexPath = collectionView.indexPath(for: cell)
            else { return }
        let text = "Hey, Check this news out..."
        let url = sourceNewsControllerTwo.shared.savedNews[indexPath.item].url
        guard let newsURL = NSURL(string: url) else { return }
        let objectsToShare = [text, newsURL] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.openInIBooks, UIActivityType("com.apple.reminders.RemindersEditorExtension")]
        activityVC.popoverPresentationController?.sourceView = sender as? UIView
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @objc func deleteNews(sender: AnyObject) {
        self.performSegue(withIdentifier: "toDeleteVC", sender: nil)
    }
    
    @objc func dismiss(sender: AnyObject) {
        guard let menuVC = presentingViewController else { return }
        self.dismiss(animated: true) {
            menuVC.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func dismissGesture(_ sender: Any) {
        guard let menuVC = presentingViewController else { return }
        self.dismiss(animated: true) {
            menuVC.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func previousNewsButton(_ sender: Any) {
        let collectionBounds = self.collectionView.bounds
        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x - collectionBounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    @IBAction func nextSwipeButton(_ sender: Any) {
        let collectionBounds = self.collectionView.bounds
        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset: CGFloat) {
        let frame: CGRect = CGRect(x: contentOffset, y: self.collectionView.contentOffset.y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
    
    func setNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}

extension SavedNewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourceNewsControllerTwo.shared.savedNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SavedNewsCollectionViewCell else { return UICollectionViewCell() }
        let news = sourceNewsControllerTwo.shared.savedNews[indexPath.item]
        cell.news = news
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDeleteVC" {
            if let destination = segue.destination as? DeleteNewsConfirmationViewController {
                guard let cell = collectionView.visibleCells.first as? SavedNewsCollectionViewCell,
                    let indexPath = collectionView.indexPath(for: cell)
                    else { return }
                let news = sourceNewsControllerTwo.shared.savedNews[indexPath.item]
                destination.news = news
            }
        }
        
//        else if segue.identifier == "toDetailVC" {
//            if let cell = collectionView.visibleCells.first as? SavedNewsCollectionViewCell {
//                if let indexPath = collectionView.indexPath(for: cell) {
//                    let vc = segue.destination as! DetailTop10NewsViewController
//                    vc.index = indexPath.item
//                    vc.newsArray = sourceNewsControllerTwo.shared.savedNews
//                }
//            }
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
