//
//  HomeCollectionViewCell.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 17/04/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeViewContainer: UIView!
    
    var news: News? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        typeViewContainer.layer.cornerRadius = 10
        typeViewContainer.clipsToBounds = true
        
        setDate()
    }
    
    func updateViews() {
        if let news = news {
            headlineLabel.text = news.title
            descriptionLabel.text = news.type
            imageView.image = news.poster
        }
    }
    
    func setDate() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let convertedDate = dateFormatter.string(from: currentDate)
        let trimmedDate = String(convertedDate)
        dateLabel.text = trimmedDate.capitalized
    }
}
