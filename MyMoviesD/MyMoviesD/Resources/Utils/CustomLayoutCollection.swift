//
//  CustomLayoutCollection.swift
//  MyMoviesD
//
//  Created by Briam Cano on 03/08/24.
//

import UIKit

class CustomLayoutCollection: UICollectionViewFlowLayout {
    var previousOffset = 0.0
    var currentpage = 0
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let cv = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        let itemCount = cv.numberOfItems(inSection: 0)
        
        if previousOffset > cv.contentOffset.x && velocity.x < 0.0 {
            currentpage = max(currentpage-1, 0)
        } else if previousOffset < cv.contentOffset.x && velocity.x > 0.0 {
            currentpage = min(currentpage+1, itemCount-1)
        }
   
        let offset = updateOffset(cv)
        previousOffset = offset
        
        return CGPoint(x: offset, y: proposedContentOffset.y)
    }
    
    func updateOffset(_ cv: UICollectionView) -> CGFloat {
        let width = cv.frame.width
        let itemWidth = itemSize.width
        let mln = minimumLineSpacing
        let edge = (width - itemWidth - mln*2) / 2
        let offset = (itemWidth + mln) * CGFloat(currentpage) - (edge + mln)
        return offset
    }
}
