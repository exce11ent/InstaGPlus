//
//  EXCollectionViewController.h
//  InstaGPlus
//
//  Created by MacUser1 on 1/9/13.
//  Copyright (c) 2013 MacUser1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GData.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "OADataManager.h"

@interface EXCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>
- (IBAction)userLogin:(id)sender;

@property NSMutableArray *internalLinks;

- (void) onExtractedLinks:(NSNotification *)n;

@end
