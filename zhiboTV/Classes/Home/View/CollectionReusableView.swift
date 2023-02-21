//
//  CollectionReusableView.swift
//  zhiboTV
//
//  Created by 林聪 on 2022/12/22.
//  Copyright © 2022 Lynn. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionReusableView: UICollectionReusableView {
    
    private lazy var lineView: UIView = { [unowned self] in
        let line = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 8))
        line.backgroundColor = UIColor(r: 234, g: 234, b: 234)
        return line
    }()
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 30, height: 30))
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: 10 + 30 + 5, y: 15, width: 150, height: 30))
        
        return titleLabel
    }()
    
    private lazy var moreBtn: UIButton = { [unowned self] in
        let moreBtn = UIButton(type: UIButton.ButtonType.custom)
        moreBtn.frame = CGRect(x: self.bounds.width - 70, y: 5, width: 60, height: self.bounds.height - 5)
        moreBtn.setTitle("更多 >", for: .normal)
        moreBtn.setTitleColor(UIColor(r: 111, g: 113, b: 121), for: .normal)
        moreBtn.titleLabel?.textAlignment = .right
        moreBtn.addTarget(self, action: #selector(clickMore), for: .touchUpInside)
        return moreBtn
    }()
    
    var gruop: AnchorGroup? {
        didSet {
            guard let gruop = gruop else { return }
            
            let url = NSURL(string: gruop.small_icon_url as String)
            let imageResource = ImageResource(downloadURL: (url! as URL))
            iconView.kf.setImage(with: imageResource)
            
            titleLabel.text = gruop.tag_name as String
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(lineView)
        self.addSubview(iconView)
        self.addSubview(titleLabel)
        self.addSubview(moreBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CollectionReusableView {
    
    @objc func clickMore() {
        
    }
}
