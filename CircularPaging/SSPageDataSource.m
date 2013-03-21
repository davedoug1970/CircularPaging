//
//  SSPageDataSource.m
//  CircularPaging
//
//  Created by David Douglas on 3/18/13.
//  Copyright (c) 2013 Software Smoothie. All rights reserved.
//

#import "SSPageDataSource.h"

@implementation SSPageDataSource 

- (int)count
{
    return 5;
}

- (UIView *)CircularPageView:(SSCircularPageController *)controller viewForPageIndex:(int)index
{
    UIView *returnView = [[UIView alloc] initWithFrame:[[controller mainView] bounds]];
    
    if (index == 0)
    {
        [returnView setBackgroundColor:[UIColor blueColor]];
        [returnView addSubview:[self createNumLabel:0]];
    }
    else if (index == 1)
    {
        [returnView setBackgroundColor:[UIColor greenColor]];
        [returnView addSubview:[self createNumLabel:1]];
    }
    else if (index == 2)
    {
        [returnView setBackgroundColor:[UIColor purpleColor]];
        [returnView addSubview:[self createNumLabel:2]];
    }
    else if (index == 3)
    {
        [returnView setBackgroundColor:[UIColor redColor]];
        [returnView addSubview:[self createNumLabel:3]];
    }
    else
    {
        [returnView setBackgroundColor:[UIColor yellowColor]];
        [returnView addSubview:[self createNumLabel:4]];
    }
    
    return returnView;
}

- (UILabel *)createNumLabel:(int)number
{
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 200, 200)];
    [numLabel setTextAlignment:NSTextAlignmentCenter];
    [numLabel setFont:[UIFont systemFontOfSize:100]];
    [numLabel setBackgroundColor:[UIColor clearColor]];
    [numLabel setTextColor:[UIColor whiteColor]];
    [numLabel setText:[NSString stringWithFormat:@"%i",number]];
    return numLabel;
}

@end
