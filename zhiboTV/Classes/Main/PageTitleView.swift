//
//  PageTitleView.swift
//  zhiboTV
//
//  Created by 林聪 on 2022/12/6.
//  Copyright © 2022 Lynn. All rights reserved.
//

import UIKit

protocol passClickLabelsIndex: class {
    func passClickLabelIndex(index: NSInteger, pageTitleView: PageTitleView)
}

private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {
    private var titles: [String]
    private let kStatusH: CGFloat = 2
    private var labelIndex: NSInteger = 0
    private var titleLabels: [UILabel] = []
    weak var delegate: passClickLabelsIndex?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine: UIView = {
        let line = UIView()
        line.backgroundColor = .red
        return line
    }()
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView {
    private func setUpUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        
        addTitles(titles: titles)
        
        setScrollLine()
    }
    
    private func addTitles(titles: [String]) {
        let labelW: CGFloat = frame.size.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.size.height - kStatusH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            label.tag = index
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            label.isUserInteractionEnabled = true
            scrollView.addSubview(label)
            
            titleLabels.append(label)
            
            let tag = UITapGestureRecognizer(target: self, action: #selector(clickLabel))
            label.addGestureRecognizer(tag)
        }
    }
    
    private func setScrollLine() {
        // 整个的线
        let line = UIView()
        let lineH: CGFloat = 0.5
        line.frame = CGRect(x: 0, y: frame.size.height - lineH, width: frame.size.width, height: lineH)
        line.backgroundColor = .darkGray
        addSubview(line)
        
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        // 滚动跟随title的线
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: 0, y: frame.size.height - kStatusH, width: frame.size.width / CGFloat(titles.count), height: kStatusH)
    }
}

extension PageTitleView {
    @objc private func clickLabel(tap: UITapGestureRecognizer) {
        
        guard let currentLabel = tap.view as? UILabel else { return }
        
        if currentLabel.tag == labelIndex { return }
        
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        let oldLabel = titleLabels[labelIndex]
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        labelIndex = currentLabel.tag
        
        let lineX = CGFloat(labelIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let self = self else { return }
            self.scrollLine.frame.origin.x = lineX
        }
        
        self.delegate?.passClickLabelIndex(index: labelIndex, pageTitleView: self)
    }
}

extension PageTitleView {
    public func getScrollProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let lineOffsetX = (targetLabel.frame.origin.x - sourceLabel.frame.origin.x) * progress
        scrollLine.frame.origin.x = lineOffsetX + sourceLabel.frame.origin.x
        
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress , g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        labelIndex = targetIndex
    }
}
