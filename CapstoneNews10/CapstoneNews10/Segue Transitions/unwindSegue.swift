//
//  unwindSegue.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 18/04/18.
//  Copyright © 2018 Jatin Menghani. All rights reserved.
//

import UIKit

class UnwindSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let firstVCView = self.source.view as UIView!
        let secondVCView = self.destination.view as UIView!
        
        let height = UIScreen.main.bounds.size.height
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(firstVCView!, aboveSubview: secondVCView!)
        
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            
            firstVCView?.frame = firstVCView!.frame.offsetBy(dx: 0.0, dy: height)
            secondVCView?.frame = secondVCView!.frame.offsetBy(dx: 0.0, dy: height)
            
            
        }) { (Finished) -> Void in
            self.source.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
