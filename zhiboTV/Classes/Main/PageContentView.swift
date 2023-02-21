//
//  PageContentView.swift
//  zhiboTV
//
//  Created by 林聪 on 2022/12/7.
//  Copyright © 2022 Lynn. All rights reserved.
//

import UIKit

protocol passScrollProgress: class{
    func passScrollProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let collectionCellID = "collectionCellID"

class PageContentView: UIView {

    private var childVCs: [UIViewController]
    private weak var parentVC: UIViewController?
    private var startOffsetX: CGFloat = 0
    weak var passScrollDelegate: passScrollProgress?
    private var isForbid: Bool = false
    
    private lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = (self?.bounds.size)!
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView.init(frame: (self?.bounds)!, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        return collectionView
    }()
    
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController?) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView {
    private func setUpUI() {
        for vc in childVCs {
            parentVC?.addChild(vc)
        }
        addSubview(collectionView)
    }
}

extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let vc = childVCs[indexPath.item]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        
        return cell
    }
}

extension PageContentView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbid = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbid { return }
        
        var progress: CGFloat = 0 // 滑动的百分比
        var sourceIndex: Int = 0 //当前title的下标
        var targetIndex: Int = 0 //即将要滚动到的下一个title的下标
        
        let currentOffsetX = scrollView.contentOffset.x
        let offset = currentOffsetX / kScreenWidth
        if currentOffsetX > startOffsetX { // 左边滑动
            progress = currentOffsetX / kScreenWidth - floor(offset)
            sourceIndex = Int(offset)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            if currentOffsetX - startOffsetX == kScreenWidth {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右边滑动
            progress = 1 - (currentOffsetX / kScreenWidth - floor(offset))
            targetIndex = Int(offset)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        passScrollDelegate?.passScrollProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

extension PageContentView {
    public func setViewFromIndex(index: NSInteger) {
        isForbid = true
        let offsetX = collectionView.frame.width * CGFloat(index)
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
