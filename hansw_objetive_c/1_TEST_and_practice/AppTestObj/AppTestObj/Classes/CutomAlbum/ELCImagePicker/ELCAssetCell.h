//
//  AssetCell.h
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

//디테일 화면을 보여주기 위해 Delegate화면을 추가하였다.
@protocol ELCAssetCellDelegate <NSObject>
- (void)ELCAssetCellTouch:(UIImage*)image;
@end

@interface ELCAssetCell : UITableViewCell

@property (nonatomic, assign) BOOL alignmentLeft;
@property (nonatomic,weak) id<ELCAssetCellDelegate> delegate;

- (void)setAssets:(NSArray *)assets;

@end
