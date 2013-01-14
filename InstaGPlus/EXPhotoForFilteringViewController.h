//
//  EXPhotoForFilteringViewController.h
//  InstaGPlus
//
//  Created by MacUser1 on 1/14/13.
//  Copyright (c) 2013 MacUser1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPhotoForFilteringViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIImage *photoForFiltering;
@property (weak, nonatomic) IBOutlet UIImageView *currentPhoto;
- (IBAction)showFilters:(id)sender;
- (IBAction)saveImgeLocally:(id)sender;

@end
