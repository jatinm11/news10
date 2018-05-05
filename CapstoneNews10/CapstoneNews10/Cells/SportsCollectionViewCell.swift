//
//  SportsCollectionViewCell.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 01/01/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    
    var sports: Sports? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let sports = sports else { return }
        imageView.image = sports.image
        categoryLabel.text = sports.name
    }
}
