//
//  ViewController.m
//  AppTestObj
//
//  Created by SANGWON HAN on 16/03/2020.
//  Copyright © 2020 SANGWON HAN. All rights reserved.
//

#import "ViewController.h"
#import "ELCImagePickerDemoViewController.h"

@interface ViewController ()

@property (strong, nonatomic) ELCImagePickerDemoViewController* mELCImagePickerDemoViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.mELCImagePickerDemoViewController = [[ELCImagePickerDemoViewController alloc] init];
}

- (IBAction)button:(id)sender {
    
    NSURL* url = [[NSURL alloc] initWithString:@"http://miaps.thinkm.co.kr/miaps3/Thinkm?scheme=aaa"];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)imageAlbumActionButton:(id)sender {
    
    self.mELCImagePickerDemoViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    //self.ReqCon.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:self.mELCImagePickerDemoViewController animated:YES completion:nil];
}



@end
