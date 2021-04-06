//Users/mediadavarkhah/Desktop/swift/my Apps/CountDownTimer/CountDownTimer/Notes/Notes/Extensions//
//  extensions.swift
//  Notes
//
//  Created by Media Davarkhah on 12/7/1399 AP.
//

import Foundation
import UIKit
extension UIView{
    
    var height:CGFloat {
        return frame.size.height
    }
    var width:CGFloat {
        return frame.size.width
    }
    var left:CGFloat {
        return frame.origin.x
    }
    var right:CGFloat {
        return left + width
    }
    var top:CGFloat {
        return frame.origin.y
        
    }
    var bottom:CGFloat {
        return top + height
        
    }
    
}
