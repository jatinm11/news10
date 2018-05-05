//
//  SportsViewController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 01/01/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class SportsViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func dismissGesture(_ sender: Any) {
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SportsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SportsConroller.sportsSources.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportsCell", for: indexPath) as? SportsCollectionViewCell else { return UICollectionViewCell() }
        let source = SportsConroller.sportsSources[indexPath.item]
        cell.sports = source
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        switch indexPath.item {
        case 0:
            sourceNewsControllerTwo.baseURL = URL(string: "https://newsapi.org/v2/top-headlines?sources=four-four-two&apiKey=f1f57f4b9504426cac6b32b9893ee604")
            sourceNewsControllerTwo.navigationTitle = "Soccer"
        case 1:
            sourceNewsControllerTwo.baseURL = URL(string: "https://newsapi.org/v2/top-headlines?sources=nfl-news&apiKey=f1f57f4b9504426cac6b32b9893ee604")
            sourceNewsControllerTwo.navigationTitle = "Football"
        case 2:
            sourceNewsControllerTwo.baseURL = URL(string: "https://newsapi.org/v2/top-headlines?sources=espn-cric-info&apiKey=f1f57f4b9504426cac6b32b9893ee604")
            sourceNewsControllerTwo.navigationTitle = "Cricket"
        default:
            break
        }
        performSegue(withIdentifier: "toNewsVC", sender: nil)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
