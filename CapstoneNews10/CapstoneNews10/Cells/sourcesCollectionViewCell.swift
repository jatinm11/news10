//
//  sourcesCollectionViewCell.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 15/10/17.
//  Copyright © 2017 Jatin Menghani. All rights reserved.
//

import UIKit

class sourcesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var sourceImageView: UIImageView!
    @IBOutlet var categoryName: UILabel!
    
    var sources: Sources? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let sources = sources else { return }
        sourceImageView.image = sources.image
        categoryName.text = sources.name.uppercased()
    }

}
