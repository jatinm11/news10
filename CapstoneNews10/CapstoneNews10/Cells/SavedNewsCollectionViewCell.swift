//
//  SavedNewsCollectionViewCell.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 20/01/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class SavedNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    var image: UIImage?
    
    var news: SourceNews? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if let news = news {
            titleLabel.text = news.title
            imageView.image = news.poster
        }
    }
}
