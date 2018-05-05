// ------------ ISKO DELETE KARNA HAI! ------------------ //
////
////  Top10NewsViewController.swift
////  CapstoneNews10
////
////  Created by Jatin Menghani on 08/10/17.
////  Copyright © 2017 Jatin Menghani. All rights reserved.
////
//
//import UIKit
//
//class Top10NewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    var currentIndex: Int = 0 {
//        didSet {
//            print(currentIndex)
//        }
//    }
//
//    var url = ""
//    var isSaved = false
//    var indexPath: Int?
//
//    @IBOutlet var collectionView: UICollectionView!
//    @IBOutlet var bottonNavationBar: UINavigationBar!
//    @IBOutlet var navigationBar: UINavigationBar!
//    @IBOutlet weak var ni: UINavigationItem!
//    @IBOutlet weak var leftButton: UIButton!
//    @IBOutlet weak var rightButton: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
//        navigationBar.isTranslucent = true
//
//        sourceNewsControllerTwo.shared.load()
//
//        let shareNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(shareNews))
//
//        let closeNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(dismiss))
//
//        shareNavigationButton.tintColor = UIColor.white
//        closeNavigationButton.tintColor = UIColor.white
//
//        let leftSideButton = [shareNavigationButton]
//        let rightRightButton = [closeNavigationButton]
//
//        self.ni.setRightBarButtonItems(rightRightButton, animated: true)
//        self.ni.setLeftBarButtonItems(leftSideButton, animated: true)
//    }
//
//    @objc func saveNews(sender: AnyObject) {
//        guard let cell = collectionView.visibleCells.first as? Top10NewsCollectionViewCell,
//            let indexPath = collectionView.indexPath(for: cell)
//            else { return }
//
//        let news = SourceNewsController.news[indexPath.item]
//        sourceNewsControllerTwo.shared.create(title: news.title, posterEndPoint: news.posterEndPoint, description: news.description, url: news.url)
//        isSaved = true
//        let saveMessage = UIStoryboard(name: "NewsSavedDeletedVCs", bundle: nil).instantiateViewController(withIdentifier: "newsSaved")
//        self.present(saveMessage, animated: true, completion: nil)
//
//        let savedImage = UIImage(named: "Saved")
//        let closeNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(dismiss))
//        let savedButton = UIBarButtonItem(image: savedImage, style: .plain, target: self, action: #selector(deleteNews))
//        savedButton.tintColor = UIColor.white
//        closeNavigationButton.tintColor = UIColor.white
//        let items = [closeNavigationButton, savedButton]
//        self.ni.setRightBarButtonItems(items, animated: true)
//    }
//
//    @objc func dismiss(sender: AnyObject) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    @objc func shareNews(sender: AnyObject) {
//        guard let cell = collectionView.visibleCells.first as? Top10NewsCollectionViewCell,
//            let indexPath = collectionView.indexPath(for: cell)
//            else { return }
//        let text = "Hey, Check this news out..."
//        let url = SourceNewsController.news[indexPath.item].url
//        guard let newsURL = NSURL(string: url) else { return }
//        let objectsToShare = [text, newsURL] as [Any]
//        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.openInIBooks, UIActivityType("com.apple.reminders.RemindersEditorExtension")]
//        activityVC.popoverPresentationController?.sourceView = sender as? UIView
//        self.present(activityVC, animated: true, completion: nil)
//    }
//
//    @objc func deleteNews(sender: AnyObject) {
//        if let indexPath = indexPath {
//            let news = SourceNewsController.news[indexPath]
//            SourceNewsController.shared.delete(news: news)
//        }
//        let deleteMessage = UIStoryboard(name: "NewsSavedDeletedVCs", bundle: nil).instantiateViewController(withIdentifier: "newsDeleted")
//        self.present(deleteMessage, animated: true, completion: nil)
//        let unSavedImage = UIImage(named: "unsaved")
//        let closeNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(dismiss))
//        let unSavedButton = UIBarButtonItem(image: unSavedImage, style: .plain, target: self, action: #selector(saveNews))
//        unSavedButton.tintColor = UIColor.white
//        closeNavigationButton.tintColor = UIColor.white
//        let items = [closeNavigationButton, unSavedButton]
//        self.ni.setRightBarButtonItems(items, animated: true)
//    }
//
//    @IBAction func swipeDownDismiss(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    @IBAction func previousNewsButton(_ sender: Any) {
//
//        let collectionBounds = self.collectionView.bounds
//        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x - collectionBounds.size.width))
//        self.moveToFrame(contentOffset: contentOffset)
//
//    }
//
//    @IBAction func nextSwipeButton(_ sender: Any) {
//
//        let collectionBounds = self.collectionView.bounds
//        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
//        self.moveToFrame(contentOffset: contentOffset)
//    }
//
//    func moveToFrame(contentOffset: CGFloat) {
//        let frame: CGRect = CGRect(x: contentOffset, y: self.collectionView.contentOffset.y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
//        self.collectionView.scrollRectToVisible(frame, animated: true)
//    }
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return SourceNewsController.news.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Top10NewsCollectionViewCell else { return UICollectionViewCell() }
//        let news = SourceNewsController.news[indexPath.item]
//        cell.layer.shadowRadius = 5
//        cell.news = news
//
//        return cell
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if let centerIndexPath: IndexPath = collectionView.centerCellIndexPath {
//            let news = SourceNewsController.news[centerIndexPath.item]
//            if SourceNewsController.shared.savedNews.contains(news) {
//                let savedImage = UIImage(named: "Saved")
//                let closeNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(dismiss))
//                let savedButton = UIBarButtonItem(image: savedImage, style: .plain, target: self, action: #selector(deleteNews))
//                savedButton.tintColor = UIColor.white
//                closeNavigationButton.tintColor = UIColor.white
//                let items = [closeNavigationButton, savedButton]
//                self.ni.setRightBarButtonItems(items, animated: true)
//            }
//            else{
//                let unSavedImage = UIImage(named: "unsaved")
//                let closeNavigationButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(dismiss))
//                let unSavedButton = UIBarButtonItem(image: unSavedImage, style: .plain, target: self, action: #selector(saveNews))
//                unSavedButton.tintColor = UIColor.white
//                closeNavigationButton.tintColor = UIColor.white
//                let items = [closeNavigationButton, unSavedButton]
//                self.ni.setRightBarButtonItems(items, animated: true)
//            }
//
//            indexPath = centerIndexPath.item
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if let cell = sender as? UICollectionViewCell, let indexPath = self.collectionView.indexPath(for: cell) {
//            let vc = segue.destination as! DetailTop10NewsViewController
//            vc.index = indexPath.item
//            vc.newsArray = SourceNewsController.news
//        }
//    }
//}
//

