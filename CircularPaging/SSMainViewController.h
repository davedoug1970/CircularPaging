//
//  SSMainViewController.h
//  CircularPaging
//
//  Created by David Douglas on 3/18/13.
//  Copyright (c) 2013 Software Smoothie. All rights reserved.
//

#import "SSFlipsideViewController.h"
#import "SSCircularPageController.h"

@interface SSMainViewController : SSCircularPageController<SSFlipsideViewControllerDelegate>

- (IBAction)showInfo:(id)sender;

@end
