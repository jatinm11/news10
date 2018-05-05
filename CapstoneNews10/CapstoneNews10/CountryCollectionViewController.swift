//
//  CountryCollectionViewController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 29/04/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class CountryCollectionViewController: UIViewController {
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectButton: UIButton!
    
    var index: Int! = 0
    var name: String?
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        selectButton.layer.cornerRadius = 7
        selectButton.clipsToBounds = true
        pageControl.numberOfPages = CountryController.shared.defaultCountries.count
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBAction func selectButtonTapped(_ sender: Any) {
        switch index {
        case 0:
            self.name = "US"
            self.imageName = "US"
        case 1:
            self.name = "IN"
            self.imageName = "IN"
        case 2:
            self.name = "UK"
            self.imageName = "GB"
        default:
            break
        }
        
        guard let name = self.name, let imageName = imageName else { return }
        CountryController.shared.createCountry(countryName: name, countryImage: imageName)
        UserDefaults.standard.set(true, forKey: "countrySelected")
        self.performSegue(withIdentifier: "toMainVC", sender: self)
    }
}

extension CountryCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CountryController.shared.defaultCountries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CountryCollectionViewCell else { return UICollectionViewCell() }
        let country = CountryController.shared.defaultCountries[indexPath.item]
        cell.country = country
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
        if let centerIndexPath: IndexPath = collectionView.centerCellIndexPath {
            self.index = centerIndexPath.item
        }
    }

}
