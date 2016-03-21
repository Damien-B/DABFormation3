//
//  CustomCollectionViewLayout.h
//  DABFormation3
//
//  Created by mac mini pprod 3 on 16/03/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, readonly) CGFloat horizontalInset;
@property (nonatomic, readonly) CGFloat verticalInset;

@property (nonatomic, readonly) CGFloat minimumItemWidth;
@property (nonatomic, readonly) CGFloat maximumItemWidth;
@property (nonatomic, readonly) CGFloat itemHeight;

@end
