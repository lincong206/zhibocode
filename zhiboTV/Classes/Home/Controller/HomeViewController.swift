//
//  Copyright © 2022 Lynn. All rights reserved.
//

import UIKit

private let kTitleViewHeight: CGFloat = 40

class HomeViewController: UIViewController {
    
    private lazy var pageTitleView: PageTitleView = { [weak self] in
        let titleFrame = CGRect.init(x: 0, y: kStatusHeight + kNavigationBar, width: kScreenWidth, height: kTitleViewHeight)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"];
        let pageView = PageTitleView.init(frame: titleFrame, titles: titles)
        pageView.delegate = self
        return pageView
    }()
    
    private lazy var contentView: PageContentView = { [weak self] in
        let pageFrame = CGRect(x: 0, y: kStatusHeight + kNavigationBar + kTitleViewHeight, width: kScreenWidth, height: kScreenHeight - (kStatusHeight + kNavigationBar + kTitleViewHeight + kTabbarH))
        var childVCs = [UIViewController]()
        childVCs.append(RecommedViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        let pageView = PageContentView(frame: pageFrame, childVCs: childVCs, parentVC: self)
        pageView.passScrollDelegate = self
        return pageView
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        setUpUI()
    }
}

extension HomeViewController {
    
    func setUpUI() {
        
//        setNav()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(contentView)
    }
    
//    func setNav() {
//
//    }
}

extension HomeViewController: passClickLabelsIndex {
    func passClickLabelIndex(index: NSInteger, pageTitleView: PageTitleView) {
        contentView.setViewFromIndex(index: index)
    }
}

extension HomeViewController: passScrollProgress {
    func passScrollProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.getScrollProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
