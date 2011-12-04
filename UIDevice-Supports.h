//
//  UIDevice-Supports.h
//
//  Created by Benjamin Borowski on 7/28/11.
//  Copyright 2011 Typeoneerror Studios. All rights reserved.
//

@interface UIDevice(Supports)

- (BOOL)deviceSupportsBackgroundTasks;
- (BOOL)deviceSupportsBluetooth;
- (BOOL)deviceSupportsGameCenter;
- (BOOL)deviceSupportsRetinaDisplay;

@end