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

    NSInteger margin = 10;
    NSInteger itemSize = 50;
    
    _layoutAttributes = [[NSMutableDictionary alloc] init];
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    for(int section = 0;section < numberOfSections;section++) {
        NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        CGFloat fullWidth = numberOfItems * itemSize + (numberOfItems+1) * margin;
        CGFloat fullHeight = itemSize + 2*margin;
        _contentSize = CGSizeMake(fullWidth, fullHeight);
        for(int item = 0;item < numberOfItems;item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectIntegral(CGRectMake(margin + item*(margin+itemSize), section*(margin+itemSize) + margin, itemSize, itemSize));
            NSString *key = [self layoutKeyForIndexPath:indexPath];
            _layoutAttributes[key] = attributes;        }
    }
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
