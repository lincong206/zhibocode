//
//  Copyright © 2022 Lynn. All rights reserved.
//

import Foundation
import UIKit

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        self.addSubViewController(vc: HomeViewController.init(), icon: "home", selIcon: "home_selected", title: "home")
        
        self.addSubViewController(vc: FollowViewController.init(), icon: "follow", selIcon: "follow_selected", title: "follow")
        
        self.addSubViewController(vc: LiveViewController.init(), icon: "live", selIcon: "live_selected", title: "live")
        
        self.addSubViewController(vc: ProfileViewController.init(), icon: "profile", selIcon: "profile_selected", title: "profile")
    }
}

extension TabbarViewController {
    private func addSubViewController(vc: UIViewController?, icon: String?, selIcon: String? ,title: String?) {
        guard let addVc = vc else {
            return
        }
        let nav = UINavigationController.init(rootViewController: addVc)
        self.setViewControllerIconAndTitle(nav: nav, icon: icon, selIcon: selIcon, title: title)
        self.addChild(nav)
    }
    
    private func setViewControllerIconAndTitle(nav: UINavigationController, icon: String?, selIcon: String? ,title: String?) {
        guard let nIcon = icon,
                let sIcon = selIcon,
                let name = title
        else {
            return
        }
        nav.viewControllers.first?.title = name
        nav.tabBarItem = UITabBarItem.init(title: name, image: UIImage.init(named: nIcon)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: sIcon)?.withRenderingMode(.alwaysOriginal))
        self.tabBar.tintColor = UIColor.init(red: 255/255, green: 0, blue: 180/255, alpha: 1.0)
    }
}
