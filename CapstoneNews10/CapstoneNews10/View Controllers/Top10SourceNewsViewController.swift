//
//  Top10SourceNewsViewController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 09/10/17.
//  Copyright © 2017 Jatin Menghani. All rights reserved.
//

import UIKit
import LNICoverFlowLayout

class Top10SourceNewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var layout: LNICoverFlowLayout!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var loadingLabel: UILabel!
    @IBOutlet weak var ni: UINavigationItem!
    @IBOutlet weak var previousNewsButton: UIButton!
    @IBOutlet weak var nextNewsButton: UIButton!
    
    var indexPath: Int?
    var navigationTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        sourceNewsControllerTwo.shared.load()
        activityIndicator.startAnimating()
        
        setNavigationBar()
        
        
        sourceNewsControllerTwo.getNews { (success) in
            if success {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.loadingLabel.isHidden = true
                    self.ni.title = sourceNewsControllerTwo.navigationTitle
                }
            }
        }
        
        let shareNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(shareNews))
        let closeNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(dismiss))
        
        shareNavigationButton.tintColor = UIColor.white
        closeNavigationButton.tintColor = UIColor.white
        
        let leftSideButton = [shareNavigationButton]
        let rightSideButton = [closeNavigationButton]
        
        self.ni.setRightBarButtonItems(rightSideButton, animated: true)
        self.ni.setLeftBarButtonItems(leftSideButton, animated: true)
        
        
    }
    
    func setNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    
    
    @objc func saveNews(sender: AnyObject) {
        guard let cell = collectionView.visibleCells.first as? Top10SourceNewsCollectionViewCell,
            let indexPath = collectionView.indexPath(for: cell)
            else { return }
        
        let news = sourceNewsControllerTwo.news[indexPath.item]
        sourceNewsControllerTwo.shared.create(title: news.title, posterEndPoint: news.posterEndPoint, description: news.description, url: news.url)
        
        let saveMessage = UIStoryboard(name: "NewsSavedDeletedVCs", bundle: nil).instantiateViewController(withIdentifier: "newsSaved")
        self.present(saveMessage, animated: true, completion: nil)
        
        let savedImage = UIImage(named: "Saved")
        let closeNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(dismiss))
        let savedButton = UIBarButtonItem(image: savedImage, style: .plain, target: self, action: #selector(deleteNews))
        savedButton.tintColor = UIColor.white
        closeNavigationButton.tintColor = UIColor.white
        let items = [closeNavigationButton, savedButton]
        self.ni.setRightBarButtonItems(items, animated: true)
    }
    

    
    @objc func dismiss(sender: AnyObject) {
        sourceNewsControllerTwo.news = []
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func shareNews(sender: AnyObject) {
        guard let cell = collectionView.visibleCells.first as? Top10SourceNewsCollectionViewCell,
            let indexPath = collectionView.indexPath(for: cell)
            else { return }
        let text = "Hey, Check this news out..."
        let url = sourceNewsControllerTwo.news[indexPath.item].url
        guard let newsURL = NSURL(string: url) else { return }
        let objectsToShare = [text, newsURL] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.openInIBooks, UIActivityType("com.apple.reminders.RemindersEditorExtension")]
        activityVC.popoverPresentationController?.sourceView = sender as? UIView
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @objc func deleteNews(sender: AnyObject) {
        if let indexPath = indexPath {
            let news = sourceNewsControllerTwo.news[indexPath]
            sourceNewsControllerTwo.shared.delete(news: news)
        }
        let deleteMessage = UIStoryboard(name: "NewsSavedDeletedVCs", bundle: nil).instantiateViewController(withIdentifier: "newsDeleted")
        self.present(deleteMessage, animated: true, completion: nil)
        let unSavedImage = UIImage(named: "unsaved")
        let closeNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(dismiss))
        let unSavedButton = UIBarButtonItem(image: unSavedImage, style: .plain, target: self, action: #selector(saveNews))
        unSavedButton.tintColor = UIColor.white
        closeNavigationButton.tintColor = UIColor.white
        let items = [closeNavigationButton, unSavedButton]
        self.ni.setRightBarButtonItems(items, animated: true)
    }
    
    @IBAction func swipeDismissAction(_ sender: Any) {
        sourceNewsControllerTwo.news = []
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func moveToFrame(contentOffset: CGFloat) {
        let frame: CGRect = CGRect(x: contentOffset, y: self.collectionView.contentOffset.y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
    
    
    @IBAction func nextPageButtonTapped(_ sender: Any) {
        let collectionBounds = self.collectionView.bounds
        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    
    @IBAction func previousPageButtonTapped(_ sender: Any) {
        let collectionBounds = self.collectionView.bounds
        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x - collectionBounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourceNewsControllerTwo.news.count
    }
    
    @objc func readButtonTapped(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "toDetailVC", sender: sender)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Top10SourceNewsCollectionViewCell else { return UICollectionViewCell() }
        let news = sourceNewsControllerTwo.news[indexPath.item]
        cell.layer.shadowRadius = 5
        cell.sourceNews = news
        cell.readButton.tag = indexPath.item
        cell.readButton.addTarget(self, action: #selector(Top10SourceNewsViewController.readButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let centerIndexPath: IndexPath = collectionView.centerCellIndexPath {
            let news = sourceNewsControllerTwo.news[centerIndexPath.item]
            if sourceNewsControllerTwo.shared.savedNews.contains(news) {
                let savedImage = UIImage(named: "Saved")
                let closeNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(dismiss))
                let savedButton = UIBarButtonItem(image: savedImage, style: .plain, target: self, action: #selector(deleteNews))
                savedButton.tintColor = UIColor.white
                closeNavigationButton.tintColor = UIColor.white
                let items = [closeNavigationButton, savedButton]
                self.ni.setRightBarButtonItems(items, animated: true)
            }
            else{
                let unSavedImage = UIImage(named: "unsaved")
                let closeNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(dismiss))
                let unSavedButton = UIBarButtonItem(image: unSavedImage, style: .plain, target: self, action: #selector(saveNews))
                unSavedButton.tintColor = UIColor.white
                closeNavigationButton.tintColor = UIColor.white
                let items = [closeNavigationButton, unSavedButton]
                self.ni.setRightBarButtonItems(items, animated: true)
            }

            indexPath = centerIndexPath.item
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if let destination = segue.destination as? DetailSourcesTop10NewsViewController {
                if let cell = sender as? UICollectionViewCell {
                    guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                    destination.index = indexPath.item
                }
                else if let button = sender as? UIButton {
                    destination.index = button.tag
                }
            }
        }
    }
}

extension UICollectionView {
    var centerPoint : CGPoint {
        get {
            return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y);
        }
    }
    var centerCellIndexPath: IndexPath? {
        if let centerIndexPath = self.indexPathForItem(at: self.centerPoint) {
            return centerIndexPath
        }
        return nil
    }
}



//        SourceNewsController.getNews(perRecordCompletion: { (indexUpdated) in
//            /// Create indexPath to insert new cell at.
//            let indexPath = IndexPath(row: indexUpdated - 1, section: 0)
//            DispatchQueue.main.async {
//                if (indexUpdated - 1) == 0 {
//                print(indexPath)
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    self.activityIndicator.stopAnimating()
//                    self.loadingLabel.isHidden = true
//                }
//                self.collectionView.reloadData()
//            }
//        }) { (success) in
//            //
//        }
