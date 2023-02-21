//
//  CollectionNormalCell.swift
//  zhiboTV
//
//  Created by 林聪 on 2023/2/18.
//  Copyright © 2023 Lynn. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {
    
    private lazy var homeLiveImage: UIImageView = { [weak self] in
        let image = UIImageView(frame: CGRect(x: 0, y: (self?.bounds.size.height ?? 0) - 24, width: 14, height: 14))
        image.image = UIImage(named: "")
        return image
    }()
    
    private lazy var title: UILabel = { [weak self] in
        let label = UILabel(frame: CGRect(x: 20, y: (self?.bounds.size.height ?? 0) - 24, width: (self?.bounds.size.width ?? 0) - 25, height: 20))
        label.text = "这个是底部标题"
        label.font = .systemFont(ofSize: 11)
        label.textColor = .lightGray
        return label
    }()
    
}
