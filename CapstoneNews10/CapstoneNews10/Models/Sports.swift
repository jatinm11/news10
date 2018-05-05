//
//  Sports.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 01/01/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class Sports {
    
    let name: String
    let image: UIImage
    
    
    init(name: String, image: UIImage) {
        self.name = name.uppercased()
        self.image = image
    }
}
