//
//  AssetCell.m
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "ELCAssetCell.h"
#import "ELCAsset.h"
#import "ELCConsole.h"
#import "ELCOverlayImageView.h"
#import <CoreLocation/CoreLocation.h>

@interface ELCAssetCell ()

@property (nonatomic, strong) NSArray *rowAssets;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) NSMutableArray *overlayViewArray;

@end

@implementation ELCAssetCell

//Using auto synthesizers

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	if (self) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
        [self addGestureRecognizer:tapRecognizer];
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:4];
        self.imageViewArray = mutableArray;
        
        NSMutableArray *overlayArray = [[NSMutableArray alloc] initWithCapacity:4];
        self.overlayViewArray = overlayArray;
        
        self.alignmentLeft = YES;
	}
	return self;
}

- (void)setAssets:(NSArray *)assets
{
    self.rowAssets = assets;
	for (UIImageView *view in _imageViewArray) {
        [view removeFromSuperview];
	}
    for (ELCOverlayImageView *view in _overlayViewArray) {
        [view removeFromSuperview];
	}
    //set up a pointer here so we don't keep calling [UIImage imageNamed:] if creating overlays
    UIImage *overlayImage = nil;
    for (int i = 0; i < [_rowAssets count]; ++i) {

        ELCAsset *asset = [_rowAssets objectAtIndex:i];

        if (i < [_imageViewArray count]) {
            UIImageView *imageView = [_imageViewArray objectAtIndex:i];
            imageView.image = [UIImage imageWithCGImage:asset.asset.thumbnail];
        } else {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:asset.asset.thumbnail]];
            [_imageViewArray addObject:imageView];
        }
        
        if (i < [_overlayViewArray count]) {
            ELCOverlayImageView *overlayView = [_overlayViewArray objectAtIndex:i];
            overlayView.hidden = asset.selected ? NO : YES;
            overlayView.labIndex.text = [NSString stringWithFormat:@"%d", asset.index + 1];
        } else {
            if (overlayImage == nil) {
                overlayImage = [UIImage imageNamed:@"check_blue_01.png"];
            }
            ELCOverlayImageView *overlayView = [[ELCOverlayImageView alloc] initWithImage:overlayImage];
            [_overlayViewArray addObject:overlayView];
            overlayView.hidden = asset.selected ? NO : YES;
            overlayView.labIndex.text = [NSString stringWithFormat:@"%d", asset.index + 1];
        }
    }
}

- (void)cellTapped:(UITapGestureRecognizer *)tapRecognizer
{
    CGPoint point = [tapRecognizer locationInView:self];
    int c = (int32_t)self.rowAssets.count;
    CGFloat totalWidth = c * 75 + (c - 1) * 4;
    CGFloat startX;
    
    if (self.alignmentLeft) {
        startX = 4;
    }else {
        startX = (self.bounds.size.width - totalWidth) / 2;
    }
    
	CGRect frame = CGRectMake(startX, 2, 75, 75);
	
	for (int i = 0; i < [_rowAssets count]; ++i) {
        if (CGRectContainsPoint(frame, point)) {
            ELCAsset *asset = [_rowAssets objectAtIndex:i];
            asset.selected = !asset.selected;
            ELCOverlayImageView *overlayView = [_overlayViewArray objectAtIndex:i];
            
            //hansw 2020.06.17 선택하였을때만 체크되도록
            if (asset.selected) {
                CGRect frameCell = overlayView.checkImage.frame;
                CGPoint pointCell = [tapRecognizer locationInView:overlayView];
                if (CGRectContainsPoint(frameCell, pointCell)){
                    NSLog(@"터치됨");
                    overlayView.hidden = !asset.selected;
                    asset.index = [[ELCConsole mainConsole] numOfSelectedElements];
                    [overlayView setIndex:asset.index+1];
                    [[ELCConsole mainConsole] addIndex:asset.index];
                }
                else{
                    NSLog(@"터치안됨");
                    asset.index = [[ELCConsole mainConsole] numOfSelectedElements];
                    [overlayView setIndex:asset.index];
                    asset.selected = !asset.selected;
                    
                    [self GoDetailView:asset];
                    
                }
                
            }
            else
            {
                overlayView.hidden = !asset.selected;
                int lastElement = [[ELCConsole mainConsole] numOfSelectedElements] - 1;
                [[ELCConsole mainConsole] removeIndex:lastElement];
            }
            break;
        }
        frame.origin.x = frame.origin.x + frame.size.width + 4;
    }
}

- (void)layoutSubviews
{
    int c = (int32_t)self.rowAssets.count;
    CGFloat totalWidth = c * 75 + (c - 1) * 4;
    CGFloat startX;
    
    if (self.alignmentLeft) {
        startX = 4;
    }else {
        startX = (self.bounds.size.width - totalWidth) / 2;
    }
    
	CGRect frame = CGRectMake(startX, 2, 75, 75);
	
	for (int i = 0; i < [_rowAssets count]; ++i) {
		UIImageView *imageView = [_imageViewArray objectAtIndex:i];
		[imageView setFrame:frame];
		[self addSubview:imageView];
        
        ELCOverlayImageView *overlayView = [_overlayViewArray objectAtIndex:i];
        [overlayView setFrame:frame];
        [self addSubview:overlayView];
		
		frame.origin.x = frame.origin.x + frame.size.width + 4;
	}
}


-(void)GoDetailView :(ELCAsset*)elcasset
{

    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    
        ALAsset *asset = elcasset.asset;
        id obj = [asset valueForProperty:ALAssetPropertyType];
        if (!obj) {
            //continue;
            return;;
        }
        NSMutableDictionary *workingDictionary = [[NSMutableDictionary alloc] init];
        
        CLLocation* wgs84Location = [asset valueForProperty:ALAssetPropertyLocation];
        if (wgs84Location) {
            [workingDictionary setObject:wgs84Location forKey:ALAssetPropertyLocation];
        }
        
        [workingDictionary setObject:obj forKey:UIImagePickerControllerMediaType];
        
        //This method returns nil for assets from a shared photo stream that are not yet available locally. If the asset becomes available in the future, an ALAssetsLibraryChangedNotification notification is posted.
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        
        if(assetRep != nil) {
            CGImageRef imgRef = nil;
            //defaultRepresentation returns image as it appears in photo picker, rotated and sized,
            //so use UIImageOrientationUp when creating our image below.
            UIImageOrientation orientation = UIImageOrientationUp;
            
            
            imgRef = [assetRep fullResolutionImage];
            orientation = [assetRep orientation];
            //imgRef = [assetRep fullScreenImage];
            
            UIImage *img = [UIImage imageWithCGImage:imgRef
                                               scale:1.0f
                                         orientation:orientation];
            
            
        }
        
    
    
    
    
}

//겔러리에 이미지 저장
-(void) SaveGallery:(UIImage*) saveImage
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:[saveImage CGImage] orientation:(ALAssetOrientation)[saveImage imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
        if (error)
        {
            //Error
            NSLog(@"실패");
        }
        else
        {
            //성공해서 파일을 지운다.
            NSLog(@"성공");
            
        }
    }];
    //[library release];
}

@end
