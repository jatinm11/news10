//
//  Top10SourceNewsCollectionViewCell.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 09/10/17.
//  Copyright © 2017 Jatin Menghani. All rights reserved.
//

import UIKit

class Top10SourceNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    var index: Int!
    
    var sourceNews: SourceNews? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func readButtonTapped(_ sender: Any) {
        
    }
    
    func updateViews() {
        if let news = sourceNews {
            titleLabel.text = news.title
            titleImageView.image = news.poster
            readButton.layer.cornerRadius = 5
            readButton.clipsToBounds = true
        }
    }
}
