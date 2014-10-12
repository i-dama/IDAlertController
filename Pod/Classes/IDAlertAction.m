//
//  IDAlertAction.m
//  IDAlertController
//
//  Created by Dama on 12/10/14.
//  Copyright (c) 2014 Dama. All rights reserved.
//

#import "IDAlertAction.h"

@interface IDAlertAction ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) IDAlertActionStyle style;
@property (nonatomic, copy) IDAlertActionHandlerBlock handlerBlock;
@end

@implementation IDAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(IDAlertActionStyle)style handler:(IDAlertActionHandlerBlock)handler{
    IDAlertAction *action = [IDAlertAction new];
    action.title = title;
    action.style = style;
    action.handlerBlock = handler;
    return action;
}

@end
