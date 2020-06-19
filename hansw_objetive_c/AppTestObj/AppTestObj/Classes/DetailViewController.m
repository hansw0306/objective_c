//
//  DetailViewController.m
//  AppTestObj
//
//  Created by SANGWON HAN on 2020/06/19.
//  Copyright © 2020 SANGWON HAN. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


@synthesize imgView,imageData,pichImg,panImg;

- (instancetype)initWithImage:(UIImage*)image
{
    self = [super init];
    if(self)
    {
        imageData = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.title = @"앨범";
    
    [imgView setUserInteractionEnabled:YES];
    [imgView setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    [imgView addGestureRecognizer:pichImg];
    [imgView addGestureRecognizer:panImg];
    
    
    if(imageData != nil)
    {
        imgView.image = imageData;
    }
}
- (IBAction)panAction:(id)sender {

    
    UIPanGestureRecognizer* recognizer = (UIPanGestureRecognizer *)sender;
    CGPoint translation = [recognizer translationInView:self.view];

    
    CGPoint newCenter = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
        if (newCenter.y >= 300 && newCenter.y <= 700 &&
            newCenter.x >= 100 && newCenter.x <=300)
        {
            recognizer.view.center = newCenter;
            [recognizer setTranslation:CGPointZero inView:self.view];
        }
}

- (IBAction)pinchAction:(id)sender {
    
    CGFloat lastScaleFactor = 1;
    CGFloat factor = [(UIPinchGestureRecognizer *) sender scale];
    
    if(factor > 1){
        //zooming in
        [pichImg view].transform = CGAffineTransformMakeScale(
                                                     lastScaleFactor + (factor -1),
                                                     lastScaleFactor + (factor -1));
    }
    else{
        //zooming out
        [pichImg view].transform = CGAffineTransformMakeScale(
                                                     lastScaleFactor,
                                                     lastScaleFactor);
    }
    if([pichImg state] == UIGestureRecognizerStateEnded)
    {
        if(factor > 1)
            lastScaleFactor += (factor-1);
        else
            lastScaleFactor *= factor;

    }
}




@end
