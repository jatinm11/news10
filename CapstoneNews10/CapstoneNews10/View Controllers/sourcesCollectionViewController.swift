//
//  sourcesCollectionViewController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 15/10/17.
//  Copyright © 2017 Jatin Menghani. All rights reserved.
//

import UIKit

class sourcesCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var upArrow: UIImageView!
    
    let numberOfItemsAtCellOne: CGFloat = 1.0
    let numberOfItemsPerRow: CGFloat = 2.0
    var height: CGFloat = 1.0
    var width: CGFloat = 1.0
    
    var source = sourceNewsControllerTwo.source
    
    var country = CountryController.shared.countries[0].countryName
    
    var gamingURL = "https://newsapi.org/v2/top-headlines?sources=polygon&apiKey=f1f57f4b9504426cac6b32b9893ee604"
    var scienceURL = "https://newsapi.org/v2/top-headlines?sources=new-scientist&apiKey=f1f57f4b9504426cac6b32b9893ee604"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        CountryController.shared.load()
    }
    
    
    @IBAction func dismissGesture(_ sender: Any) {
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SourcesController.sources.count
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sourcesCVVC", for: indexPath) as? sourcesCollectionViewCell else { return UICollectionViewCell() }
        let source = SourcesController.sources[indexPath.item]
        cell.sources = source
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        height = collectionView.frame.height / 3
        width = collectionView.frame.width / numberOfItemsPerRow
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            sourceNewsControllerTwo.baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&category=business&pageSize=10&apiKey=f1f57f4b9504426cac6b32b9893ee604")
            sourceNewsControllerTwo.navigationTitle = "Business"
        case 1:
            sourceNewsControllerTwo.baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&category=politics&pageSize=10&apiKey=f1f57f4b9504426cac6b32b9893ee604")
            sourceNewsControllerTwo.navigationTitle = "Politics"
        case 2:
            self.performSegue(withIdentifier: "toSportsVC", sender: nil)
        case 3:
            sourceNewsControllerTwo.baseURL = URL(string: self.gamingURL)
            sourceNewsControllerTwo.navigationTitle = "Gaming"
        case 4:
            sourceNewsControllerTwo.baseURL = URL(string: self.scienceURL)
            sourceNewsControllerTwo.navigationTitle = "Science"
        case 5:
            sourceNewsControllerTwo.baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&category=technology&pageSize=10&apiKey=f1f57f4b9504426cac6b32b9893ee604")
            sourceNewsControllerTwo.navigationTitle = "Technology"
        case 6:
            sourceNewsControllerTwo.baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&category=entertainment&pageSize=10&apiKey=f1f57f4b9504426cac6b32b9893ee604")
            sourceNewsControllerTwo.navigationTitle = "Entertainment"
        case 7:
            self.performSegue(withIdentifier: "toSavedVC", sender: nil)
        default:
            break
        }
        self.performSegue(withIdentifier: "toSourceVC", sender: nil)
    }
}
