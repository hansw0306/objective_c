//
//  ViewController.m
//  AppTestObj
//
//  Created by SANGWON HAN on 16/03/2020.
//  Copyright © 2020 SANGWON HAN. All rights reserved.
//

#import "ViewController.h"
#import "ELCImagePickerDemoViewController.h"

#import "DetailViewController.h"

#import <ImageIO/ImageIO.h>
#import <ImageIO/CGImageProperties.h>
#import <ImageIO/CGImageSource.h>

@interface ViewController () 

@property (strong, nonatomic) ELCImagePickerDemoViewController* mELCImagePickerDemoViewController;
@property (strong, nonatomic) UIImagePickerController *picker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.mELCImagePickerDemoViewController = [[ELCImagePickerDemoViewController alloc] init];
}

- (IBAction)button:(id)sender {
    
//    NSURL* url = [[NSURL alloc] initWithString:@"http://miaps.thinkm.co.kr/miaps3/Thinkm?scheme=aaa"];
//    [[UIApplication sharedApplication] openURL:url];
    
    //DetailViewController *mDetailViewController = [[DetailViewController alloc] init];
    //[self presentViewController:mDetailViewController animated:YES completion:nil];
    
    //DetailViewController *mDetailViewController = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    
    
    
    DetailViewController *mDetailViewController = [[DetailViewController alloc] initWithNibName: nil bundle: nil];
    [self.navigationController pushViewController:mDetailViewController animated:YES];
    
    
}
- (IBAction)imageAlbumActionButton:(id)sender {
    
    self.mELCImagePickerDemoViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    //self.ReqCon.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:self.mELCImagePickerDemoViewController animated:YES completion:nil];
}

- (IBAction)NativeAlbumActionButton:(id)sender {
    

    //앨범 화면 띄우기
//    self.picker = [[UIImagePickerController alloc] init];
//    [self.picker setDelegate:self];
//    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentViewController:self.picker animated:YES completion:nil];
    

    
    
    
    //로컬에 있는 이미지의 meta정보 가져오는 함수 구현
    NSArray* arrPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString* sPath = [arrPath objectAtIndex:0];
    sPath = [sPath stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    
    [self GetImageData:[NSString stringWithFormat:@"%@/image.png",sPath]];
    
}


-(void) GetImageData:(NSString *)sScreenShotPath
{
    
    NSData *imagedata = [NSData dataWithContentsOfFile:sScreenShotPath];
    CGImageSourceRef source = CGImageSourceCreateWithData((CFMutableDataRef)imagedata, NULL);
    //NSDictionary *metadata = [(NSDictionary *)CGImageSourceCopyPropertiesAtIndex(source,0,NULL)autorelease];
    //NSLog(@"%@",metadata);
       CFDictionaryRef dictRef = CGImageSourceCopyPropertiesAtIndex(source,0,NULL);
       NSDictionary* metadata = (__bridge NSDictionary *)dictRef;
       NSLog(@"metadata= %@", metadata);
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self.picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
  //UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    PHAsset* asset = info[UIImagePickerControllerPHAsset];
    [asset requestContentEditingInputWithOptions:nil completionHandler:^(PHContentEditingInput *contentEditingInput, NSDictionary *info) {
        CIImage *fullImage = [CIImage imageWithContentsOfURL:contentEditingInput.fullSizeImageURL];
        NSDictionary *imageMetaData = fullImage.properties.description;
        NSLog(@"%@", imageMetaData);
    }];

    
    
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}

@end
