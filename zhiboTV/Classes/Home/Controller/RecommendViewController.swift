//
//  Copyright © 2022 Lynn. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenWidth - 3 * kItemMargin) / 2
private let kNormalItemH: CGFloat = kItemW * 3 / 4
private let kPrettyItemH: CGFloat = kItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderCellID = "kHeaderCellID"

class RecommedViewController: UIViewController {
    
    private lazy var recommenVM: RecommendViewModel = RecommendViewModel()
    
    private lazy var dataArr: NSMutableArray = NSMutableArray()
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(NornalCollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(PrettyCollectionViewCell.self, forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderCellID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        loadData()
    }
}

extension RecommedViewController {
    private func setUpUI() {
        self.view.addSubview(collectionView)
    }
    
    private func loadData() {
        recommenVM.requestData {
            self.collectionView.reloadData()
        }
    }
}

extension RecommedViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        recommenVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let gruop = recommenVM.anchorGroups[section]
        
        return gruop.anchos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let gruop = recommenVM.anchorGroups[indexPath.section]
        let anchor = gruop.anchos[indexPath.item]
        
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! PrettyCollectionViewCell
            cell.anchor = anchor
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NornalCollectionViewCell
            cell.anchor = anchor
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderCellID, for: indexPath) as! CollectionReusableView
        
        header.gruop = recommenVM.anchorGroups[indexPath.section]
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
