//
//  UIDevice-Supports.m
//  OU1
//
//  Created by Benjamin Borowski on 7/28/11.
//  Copyright 2011 Typeoneerror Studios. All rights reserved.
//

#import <sys/utsname.h>
#import "UIDevice-Hardware.h"
#import "UIDevice-Supports.h"

@implementation UIDevice(Supports)

- (BOOL)deviceSupportsBackgroundTasks
{
    UIDevice* device = [UIDevice currentDevice];
    BOOL backgroundSupported = NO;
    if ([device respondsToSelector:@selector(isMultitaskingSupported)])
    {
        backgroundSupported = device.multitaskingSupported;
    }
    return backgroundSupported;
}

- (BOOL)deviceSupportsBluetooth
{
    NSString *platform = [self platform];
    
    if ([platform isEqualToString:@"i386"] ||
        [platform isEqualToString:@"iPhone1,1"] ||
        [platform isEqualToString:@"iPod1,1"])
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)deviceSupportsGameCenter
{
    // Check for presence of GKLocalPlayer API.
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // The device must be running running iOS 4.1 or later.
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    
    // 1st Gen iPod and 3G don't support Game Center
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *theModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //NSLog(@"system is %@ and os version supported is %d and gcClass is %@ and currSysVer is %@", theModel, osVersionSupported, gcClass, currSysVer);
    
    // 3g and iPod Touch 1st gen do NOT support bluetooth
    if ([theModel isEqualToString:@"iPhone1,2"] ||
        [theModel isEqualToString:@"iPod1,1"])
    {
        return FALSE;
    }
    
    return (gcClass && osVersionSupported);
}

@end
