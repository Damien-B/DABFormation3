//
//  CustomCollectionViewLayout.m
//  DABFormation3
//
//  Created by mac mini pprod 3 on 16/03/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import "CustomCollectionViewLayout.h"

@interface CustomCollectionViewLayout(){
    NSMutableDictionary *_layoutAttributes;
    CGSize _contentSize;
}

@end

@implementation CustomCollectionViewLayout



-(void)prepareLayout {
    [super prepareLayout];

    NSInteger numberOfSections = [self.collectionView numberOfSections];

    for(int section = 0;section < numberOfSections;section++) {
        NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        CGFloat fullWidth = numberOfItems * 50 + (numberOfItems+1) * 10;
        CGFloat fullHeight = 50 + 2*10;
        _contentSize = CGSizeMake(fullWidth, fullHeight);
        
    
            for(int item = 0;item < numberOfItems;item++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
                UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //            BOOL increaseRow = NO;
    //            if(self.collectionView.frame.size.width - xOffset > self.maximumItemWidth*1.5f) {
    //                itemSize = [self randomItemSize];
    //            }else{
    //                itemSize.width = self.collectionView.frame.size.width - xOffset - self.horizontalInset;
    //                itemSize.height = self.itemHeight;
    //                increaseRow = YES;
    //            }
                attributes.frame = CGRectIntegral(CGRectMake(10 + item*(10+50), 10, 50, 50));
                NSString *key = [self layoutKeyForIndexPath:indexPath];
                _layoutAttributes[key] = attributes;
    //
    //            xOffset += itemSize.width;
    //            xOffset += self.horizontalInset;
    //
    //            if(increaseRow && !(item == numberOfItems-1 && section == numberOfSections-1)) {
    //                yOffset += self.verticalInset;
    //                yOffset += self.itemHeight;
    //                xOffset = self.horizontalInset;
    //            }
    //            
            }
        
            }
    
    
    
//        CGFloat xOffset = self.horizontalInset;
//
//    yOffset += self.itemHeight;
    
    
}


-(NSString *)layoutKeyForIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%ld_%ld", (long)indexPath.section, (long)indexPath.row];
}

-(CGSize)collectionViewContentSize {
    return _contentSize;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [self layoutKeyForIndexPath:indexPath];
    return _layoutAttributes[key];
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
        UICollectionViewLayoutAttributes *layoutAttribute = _layoutAttributes[evaluatedObject];
        return CGRectIntersectsRect(rect, [layoutAttribute frame]);
    }];
    
    NSArray *matchingKeys = [[_layoutAttributes allKeys] filteredArrayUsingPredicate:predicate];
    return [_layoutAttributes objectsForKeys:matchingKeys notFoundMarker:[NSNull null]];
}

@end
