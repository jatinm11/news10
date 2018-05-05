//
//  HeadlineViewController.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 08/10/17.
//  Copyright © 2017 Jatin Menghani. All rights reserved.
//

import UIKit

class HeadlineViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var navItem: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDate()
        
        CountryController.shared.load()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        pageControl.numberOfPages = SourceNewsController.news.count
        
        setNavigationBar()
    }
    
    func setNavigationBar() {
        
        let button = UIButton.init(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "navMenuIcon.png"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(hello), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)

        let countryName = CountryController.shared.countries[0].countryName
        let country = UIButton.init(type: .custom)
        country.setTitle(countryName, for: .normal)
        let barButtonTwo = UIBarButtonItem(customView: country)
        
        self.navItem.leftBarButtonItems = [barButton, barButtonTwo]
        
        
        let globeButton = UIButton.init(type: .custom)
        globeButton.setImage(UIImage(named: "globeIconThree.png"), for: .normal)
        let rightBarButton = UIBarButtonItem(customView: globeButton)
        
        self.navItem.rightBarButtonItem = rightBarButton
        
//        let flagImage = UIImage(named: "united-states.png")
//        let menuNavigationButton = UIBarButtonItem(image: flagImage, style: .plain, target: self, action: nil)
//
//        self.navItem.setLeftBarButton(menuNavigationButton, animated: true)
    }
    
    @objc func hello() {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBAction func toTestVc(_ sender: Any) {
        
        let countryCodeName = CountryController.shared.countries[0].imageName
        
        if let centerIndexPath: IndexPath = collectionView.centerCellIndexPath {
            let news = SourceNewsController.news[centerIndexPath.item]
            
            switch news.type {
            case "Business":
                sourceNewsControllerTwo.baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=\(countryCodeName)&category=business&pageSize=10&apiKey=f1f57f4b9504426cac6b32b9893ee604")
                sourceNewsControllerTwo.navigationTitle = "Business"
                
            case "Politics":
                sourceNewsControllerTwo.baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=\(countryCodeName)&category=politics&pageSize=10&apiKey=f1f57f4b9504426cac6b32b9893ee604")
                sourceNewsControllerTwo.navigationTitle = "Politics"
                
            case "Science":
                sourceNewsControllerTwo.baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=\(countryCodeName)&category=science&pageSize=10&apiKey=f1f57f4b9504426cac6b32b9893ee604")
                sourceNewsControllerTwo.navigationTitle = "Science"
                
            case "Gaming":
                sourceNewsControllerTwo.baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=\(countryCodeName)&category=gaming&pageSize=10&apiKey=f1f57f4b9504426cac6b32b9893ee604")
                sourceNewsControllerTwo.navigationTitle = "Gaming"
                
            case "Technology":
                sourceNewsControllerTwo.baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=\(countryCodeName)&category=technology&pageSize=10&apiKey=f1f57f4b9504426cac6b32b9893ee604")
                sourceNewsControllerTwo.navigationTitle = "Technology"
                
            case "Entertainment":
                sourceNewsControllerTwo.baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=\(countryCodeName)&category=entertainment&pageSize=10&apiKey=f1f57f4b9504426cac6b32b9893ee604")
                sourceNewsControllerTwo.navigationTitle = "Entertainment"
                
            default:
                sourceNewsControllerTwo.baseURL = URL(string: "nil")
                sourceNewsControllerTwo.navigationTitle = "Nothing"
            }
        }
        
        self.performSegue(withIdentifier: "testVC", sender: self)
    }
    
    func setDate() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let convertedDate = dateFormatter.string(from: currentDate)
        let _ = String(convertedDate)
//        dateLabel.text = trimmedDate.capitalized
    }


    
    @IBAction func toSourcesVCSwipeGesture(_ sender: Any) {
        let impact = UIImpactFeedbackGenerator(style: .medium)
        let sourcesVC = UIStoryboard(name: "Sources", bundle: nil).instantiateViewController(withIdentifier: "sourcesVCC")
        impact.impactOccurred()
        present(sourcesVC, animated: true, completion: nil)
    }
    
    @IBAction func downArrowButtonClicked(_ sender: Any) {
        let sourcesVC = UIStoryboard(name: "Sources", bundle: nil).instantiateViewController(withIdentifier: "sourcesVCC")
        present(sourcesVC, animated: true, completion: nil)
    }
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue) {
        print("its happening")
    }
    
}


extension HeadlineViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SourceNewsController.news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        let news = SourceNewsController.news[indexPath.item]
        cell.news = news
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}

extension String {
    func dropLast(_ n: Int = 1) -> String {
        return String(dropLast(n))
    }
}
