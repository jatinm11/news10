//
//  SegueFromBottom.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 18/04/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class SegueFromBottom: UIStoryboardSegue {
    
    override func perform() {
        
        let firstVCView = self.source.view as UIView!
        let secondVCView = self.destination.view as UIView!
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        
        secondVCView?.frame = CGRect(x: 0.0, y: height, width: width, height: height)
        
        let window = UIApplication.shared.keyWindow
        window!.insertSubview(secondVCView!, aboveSubview: firstVCView!)
        
        
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            
            firstVCView?.frame = firstVCView!.frame.offsetBy(dx: 0.0, dy: -height)
            secondVCView?.frame = secondVCView!.frame.offsetBy(dx: 0.0, dy: -height)
            
            
        }) { (Finished) -> Void in
            self.source.present(self.destination, animated: false, completion: nil)
        }
    }
    
}
