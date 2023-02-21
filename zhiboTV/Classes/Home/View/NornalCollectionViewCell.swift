//
//  NornalCollectionViewCell.swift
//  zhiboTV
//
//  Created by 林聪 on 2023/2/20.
//  Copyright © 2023 Lynn. All rights reserved.
//

import UIKit
import Kingfisher

class NornalCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height - 5 - 14 - 10))
        imgView.layer.cornerRadius = 5
        imgView.layer.masksToBounds = true
        return imgView
    }()
 
    private lazy var smallImageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: self.bounds.size.height - 24, width: 14, height: 14))
        
        return imgView
    }()
    
    private lazy var roomName: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: self.bounds.size.height - 24, width: self.bounds.size.width - 25, height: 14))
        label.font = .systemFont(ofSize: 11.0)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var nickName: UILabel = {
        let label = UILabel(frame: CGRect(x: 5, y: self.imageView.bounds.size.height - 14 - 5, width: self.imageView.bounds.width - 5 - 65, height: 14))
        label.font = .systemFont(ofSize: 11.0)
        label.textColor = .white
        return label
    }()
    
    private lazy var onlineBtn: UIButton = { [unowned self] in
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.frame = CGRect(x: self.imageView.bounds.width - 65, y: self.imageView.bounds.size.height - 16 - 5, width: 65, height: 16)
        btn.setTitle("6666在线", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 11.0)
        btn.addTarget(self, action: #selector(clickMore), for: .touchUpInside)
        return btn
    }()
    
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            
            let url = NSURL(string: anchor.vertical_src as String)
            let imageResource = ImageResource(downloadURL: (url! as URL))
            imageView.kf.setImage(with: imageResource)
            
            roomName.text = anchor.room_name as String?
            nickName.text = anchor.nickname as String?
            var onlineNumber = ""
            if anchor.online >= 10000 {
                onlineNumber = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineNumber = "\(Int(anchor.online))在线"
            }
            onlineBtn.setTitle(onlineNumber, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.smallImageView)
        self.addSubview(self.roomName)
        self.addSubview(self.imageView)
        
        self.imageView.addSubview(self.nickName)
        self.imageView.addSubview(self.onlineBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NornalCollectionViewCell {
    
    @objc func clickMore() {
        
    }
}
