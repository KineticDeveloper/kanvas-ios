//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Foundation
import UIKit

final class FilterCollectionView: IgnoreTouchesView {
    
    let collectionView: FilterCollection
    
    init(cellWidth: CGFloat, cellHeight: CGFloat, ignoreTouches: Bool = false) {
        let layout = FilterCollectionLayout(cellWidth: cellWidth, minimumHeight: cellHeight)
        collectionView = FilterCollection(frame: .zero, collectionViewLayout: layout, ignoreTouches: ignoreTouches)
        collectionView.accessibilityIdentifier = "Filter Collection"
        
        super.init(frame: .zero)
        
        clipsToBounds = false
        setUpViews()
    }
    
    @available(*, unavailable, message: "use init() instead")
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    @available(*, unavailable, message: "use init() instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        collectionView.add(into: self)
        collectionView.clipsToBounds = false
    }
    
}

final class FilterCollection: UICollectionView {
    
    var ignoreTouches = false
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, ignoreTouches: Bool) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.ignoreTouches = ignoreTouches
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .clear
        isScrollEnabled = true
        allowsSelection = true
        bounces = true
        alwaysBounceHorizontal = true
        alwaysBounceVertical = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        autoresizesSubviews = true
        contentInset = .zero
        decelerationRate = UIScrollView.DecelerationRate.fast
        dragInteractionEnabled = true
        reorderingCadence = .immediate
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        
        if ignoreTouches {
            return hitView == self ? nil : hitView
        }
        else {
            return hitView
        }
    }
}

private final class FilterCollectionLayout: UICollectionViewFlowLayout {
    
    init(cellWidth: CGFloat, minimumHeight: CGFloat) {
        super.init()
        configure(cellWidth: cellWidth, minimumHeight: minimumHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(cellWidth: CGFloat, minimumHeight: CGFloat) {
        scrollDirection = .horizontal
        itemSize = UICollectionViewFlowLayout.automaticSize
        estimatedItemSize = CGSize(width: cellWidth, height: minimumHeight)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
    }
}
