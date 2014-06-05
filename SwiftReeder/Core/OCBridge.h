//
//  OCBridge.h
//  SwiftReeder
//
//  Created by Thilong on 14/6/4.
//  Copyright (c) 2014年 thilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface OCBridge : NSObject

+ (void)messageBox:(NSString *)title msg:(NSString *)msg;
+ (UIAlertView *)createHUDMsg:(NSString *)string;
+ (NSString *)feedCachePath:(BOOL)check;

+ (void)initUI;

@end
