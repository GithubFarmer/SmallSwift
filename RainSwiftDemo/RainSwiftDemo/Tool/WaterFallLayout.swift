//
//  WaterFallLayout.swift
//  RainSwiftDemo
//
//  Created by 喻永权 on 2019/4/17.
//  Copyright © 2019年 喻永权. All rights reserved.
//

import UIKit

protocol WaterFallDataSource {
    func colsInWaterFall(_ waterFall : WaterFallLayout) -> Int;
    func itemHeightInWaterFall(_ waterFall: WaterFallLayout) -> CGFloat;
}

class WaterFallLayout: UICollectionViewFlowLayout {
    var dataSource : WaterFallDataSource?
    fileprivate var attrsArray : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate var maxH : CGFloat = 0
    fileprivate lazy var colHeights : [CGFloat] = {
        let cols = self.dataSource?.colsInWaterFall(self)
        return Array.init(repeating: self.sectionInset.top, count: cols!)
    }()
    fileprivate var startIndex = 0
    override func prepare() {
        super.prepare()
        let itemCount = self.collectionView!.numberOfItems(inSection: 0)
        let cols = dataSource?.colsInWaterFall(self)
        let itemW = (kScreenW - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * CGFloat(cols! - 1) ) / CGFloat(cols!)
        
        for i in startIndex ..< itemCount {
            let indexPath = IndexPath.init(row: i, section: 0)
            let attrs = UICollectionViewLayoutAttributes.init(forCellWith:indexPath as IndexPath)
            guard let height = dataSource?.itemHeightInWaterFall(self) else {
                assert(true, "请先实现waterFall的代理")
                return
            }
            //核心代码
            var minH = colHeights.min()!
            let index = colHeights.index(of: minH)!
            minH = minH + height + self.minimumLineSpacing
            colHeights[index] = minH
            attrs.frame = CGRect(x: self.sectionInset.left + (self.minimumInteritemSpacing + itemW) * CGFloat(index), y: minH - height - self.minimumLineSpacing, width: itemW, height: height)
            attrsArray.append(attrs)
        }
        maxH = colHeights.max()!;
        startIndex = itemCount
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize.init(width: 0, height: maxH + self.sectionInset.bottom - minimumLineSpacing)
    }
}
