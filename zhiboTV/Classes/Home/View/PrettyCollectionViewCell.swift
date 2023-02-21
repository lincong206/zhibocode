//
//  PrettyCollectionViewCell.swift
//  zhiboTV
//
//  Created by 林聪 on 2023/2/20.
//  Copyright © 2023 Lynn. All rights reserved.
//

import UIKit
import Kingfisher

class PrettyCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height - 5 - 16 - 5 - 14 - 10))
        imgView.layer.cornerRadius = 5
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    private lazy var onlieLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: self.imageView.bounds.size.width - 60 - 5, y: 5, width: 60, height: 20))
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11.0)
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var titleName: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: self.bounds.size.height - 16 - 5 - 14 - 10, width: self.bounds.size.width - 5, height: 16))
        label.font = .systemFont(ofSize: 13.0)
        return label
    }()
    
    private lazy var loclaLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: self.bounds.size.height - 14 - 10, width: 100, height: 14))
        label.font = .systemFont(ofSize: 11.0)
        label.textColor = .lightGray
        return label
    }()
    
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            let url = NSURL(string: anchor.vertical_src as String)
            let imageResource = ImageResource(downloadURL: (url! as URL))
            imageView.kf.setImage(with: imageResource)

            titleName.text = anchor.nickname as String
            var onlineNumber = ""
            if anchor.online >= 10000 {
                onlineNumber = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineNumber = "\(Int(anchor.online))在线"
            }
            onlieLabel.text = onlineNumber
            loclaLabel.text = anchor.anchor_city as String
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView.addSubview(self.onlieLabel)
        
        self.addSubview(self.imageView)
        self.addSubview(self.titleName)
        self.addSubview(self.loclaLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PrettyCollectionViewCell {
    
    @objc func clickMore() {
        
    }
}
