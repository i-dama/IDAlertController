//
//  IDAlertAction.h
//  IDAlertController
//
//  Created by Dama on 12/10/14.
//  Copyright (c) 2014 Dama. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IDAlertAction;

typedef void (^IDAlertActionHandlerBlock) (IDAlertAction *action);

typedef NS_ENUM(NSUInteger, IDAlertActionStyle) {
    IDAlertActionStyleDefault = 0,
    IDAlertActionStyleCancel,
    IDAlertActionStyleDestructive
};

@interface IDAlertAction : NSObject
+ (instancetype)actionWithTitle:(NSString *)title style:(IDAlertActionStyle)style handler:(IDAlertActionHandlerBlock)handler;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) IDAlertActionStyle style;
@property (nonatomic, copy, readonly) IDAlertActionHandlerBlock handlerBlock;

//don't use this!
@property (nonatomic, assign) NSInteger assignedIndex;
@end
