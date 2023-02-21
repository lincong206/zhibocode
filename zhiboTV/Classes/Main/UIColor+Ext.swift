//
//  Copyright © 2022 Lynn. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(r: CGFloat, g:CGFloat, b:CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
