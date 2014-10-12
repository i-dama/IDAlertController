//
//  IDAlertController.h
//  IDAlertController
//
//  Created by Dama on 12/10/14.
//  Copyright (c) 2014 Dama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDAlertAction.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IDAlertControllerStyle) {
    IDAlertControllerStyleActionSheet = 0,
    IDAlertControllerStyleAlert
};

typedef void (^IDAlertControllerTextFieldConfigurationHandler)(UITextField *textField);

@interface IDAlertController : NSObject

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(IDAlertControllerStyle)preferredStyle;
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(IDAlertControllerStyle)preferredStyle actions:(NSArray *)actions;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, readonly) IDAlertControllerStyle preferredStyle;

//actions
- (void)addAction:(IDAlertAction *)action;
- (void)addActionWithTitle:(NSString *)title style:(IDAlertActionStyle)style handler:(IDAlertActionHandlerBlock)handler;
@property(nonatomic, readonly) NSArray *actions;

//display
- (void)show;
- (void)showInViewController:(UIViewController *)viewController;
- (void)showInViewController:(UIViewController *)viewController completion:(void (^)(void))completion;

@end
