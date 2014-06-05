//
//  OCBridge.m
//  SwiftReeder
//
//  Created by Thilong on 14/6/4.
//  Copyright (c) 2014年 thilong. All rights reserved.
//

#import "OCBridge.h"
#import <UIKit/UIKit.h>


@implementation OCBridge

+ (void)messageBox:(NSString *)title msg:(NSString *)msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alertView show];
}

+ (UIAlertView *)createHUDMsg:(NSString *)string{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:string delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    return alertView;
}

+ (NSString *)feedCachePath:(BOOL)check{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data"];
    if(!check) return path;
    if(access(path.UTF8String, 0)!=-1)
        return path;
    return nil;
}

+ (void)initUI{
    UIColor *color = [[UIColor alloc] initWithRed:175.0 /255 green:23.0/255 blue:39.0/255 alpha:1];
    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor :color}];
}

@end
