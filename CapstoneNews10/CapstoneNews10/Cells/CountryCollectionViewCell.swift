//
//  CountryCollectionViewCell.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 01/05/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    var country: Country? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if let country = country {
            self.imageView.image = UIImage(named: country.imageName)
            countryNameLabel.text = country.countryName
        }
    }
}
