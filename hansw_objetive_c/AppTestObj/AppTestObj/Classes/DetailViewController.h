//
//  DetailViewController.h
//  AppTestObj
//
//  Created by SANGWON HAN on 2020/06/19.
//  Copyright © 2020 SANGWON HAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN
@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panImg;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pichImg;
@property (strong, nonatomic) PHAsset *detailData;

@end
NS_ASSUME_NONNULL_END
