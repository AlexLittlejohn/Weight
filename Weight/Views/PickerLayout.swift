//
//  PickerLayout.swift
//  Weight
//
//  Created by Alex Littlejohn on 2016/03/02.
//  Copyright © 2016 Alex Littlejohn. All rights reserved.
//

import UIKit

class PickerLayout: UICollectionViewFlowLayout {
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView else {
            return proposedContentOffset
        }
        
        var offsetAdjustment = CGFloat.max
        let verticalCenter = proposedContentOffset.y + collectionView.bounds.height / 2.0
        
        let targetRect = CGRect(x: 0, y: proposedContentOffset.y, width: collectionView.bounds.width, height: collectionView.bounds.height)
        let array = collectionView.collectionViewLayout.layoutAttributesForElementsInRect(targetRect)!
        
        for layoutAttributes in array {
            let itemVerticalCenter = layoutAttributes.center.y
            if (abs(itemVerticalCenter - verticalCenter) < abs(offsetAdjustment)) {
                offsetAdjustment = itemVerticalCenter - verticalCenter
            }
        }
        
        let targetOffset = CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y + offsetAdjustment)
        
        return targetOffset
    }
}
