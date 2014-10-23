//
//  IDAlertController.m
//  IDAlertController
//
//  Created by Dama on 12/10/14.
//  Copyright (c) 2014 Dama. All rights reserved.
//

#import "IDAlertController.h"
#import <objc/runtime.h>

NSString *const IDAlertControllerActionSheetOptionSourceViewKey = @"IDAlertControllerActionSheetOptionSourceViewKey";
NSString *const IDAlertControllerActionSheetOptionSourceRectKey = @"IDAlertControllerActionSheetOptionSourceRectKey";
NSString *const IDALertControllerActionSheetOptionBarButtonItemKey = @"IDALertControllerActionSheetOptionBarButtonItemKey";

static const char IDAlertActionKey;
static const char RetainSelfKey;

@interface IDAlertController () <UIAlertViewDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) NSMutableArray *_actions;
@property (nonatomic, strong) IDAlertAction *cancelAction;
@property (nonatomic, strong) IDAlertAction *destructiveAction;
@property(nonatomic, assign) IDAlertControllerStyle preferredStyle;
@property (nonatomic, strong) NSDictionary *actionSheetOptions;
@end

@implementation IDAlertController
@dynamic actions;

#pragma mark - Initialisation

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(IDAlertControllerStyle)preferredStyle{
    return [self alertControllerWithTitle:title message:message preferredStyle:preferredStyle actionSheetOptions:nil];
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(IDAlertControllerStyle)preferredStyle actionSheetOptions:(NSDictionary *)actionSheetOptions{
    IDAlertController *controller = [IDAlertController new];
    controller.title = title;
    controller.message = message;
    controller.preferredStyle = preferredStyle;
    controller._actions = [NSMutableArray array];
    controller.actionSheetOptions = actionSheetOptions;
    return controller;
}

- (NSArray *)actions{
    return self._actions;
}

- (void)addActionWithTitle:(NSString *)title style:(IDAlertActionStyle)style handler:(IDAlertActionHandlerBlock)handler{
    [self addAction:[IDAlertAction actionWithTitle:title style:style handler:handler]];
}

- (void)addCancelActionWithTitle:(NSString *)title{
    [self addActionWithTitle:title style:IDAlertActionStyleCancel handler:nil];
}

- (void)addAction:(IDAlertAction *)action{
    NSAssert(action, @"Action cannot be nil");
    NSAssert(!(self.preferredStyle == IDAlertControllerStyleAlert && action.style == IDAlertActionStyleDestructive), @"Alert cannot have a destructive action");
    NSAssert(!(action.style == IDAlertActionStyleCancel && self.cancelAction != nil), @"Can only have 1 Cancel action");
    NSAssert(!(action.style == IDAlertActionStyleDestructive && self.destructiveAction != nil), @"Can only have 1 Destructive action");
    switch (action.style) {
        case IDAlertActionStyleCancel:
            self.cancelAction = action;
            break;
        case IDAlertActionStyleDestructive:
            self.destructiveAction = action;
            break;
        default:
            [self._actions addObject:action];
            break;
    }
}

- (BOOL)isAlertControllerAvailable{
    return NSClassFromString(@"UIAlertController") != nil;
}

#pragma mark - UI objects creation

- (UIAlertView *)alertView{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:self.title message:self.message delegate:self cancelButtonTitle:self.cancelAction.title otherButtonTitles:nil];
    for(IDAlertAction *action in self._actions){
        NSInteger index =[alertView addButtonWithTitle:action.title];
        action.assignedIndex = index;
    }
    objc_setAssociatedObject(alertView, &RetainSelfKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return alertView;
}

- (UIActionSheet *)actionSheet{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:self.title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for(IDAlertAction *action in self._actions){
        NSInteger index = [actionSheet addButtonWithTitle:action.title];
        action.assignedIndex = index;
    }
    if(self.destructiveAction){
        actionSheet.destructiveButtonIndex = [actionSheet addButtonWithTitle:self.destructiveAction.title];
    }
    if(self.cancelAction){
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:self.cancelAction.title];
    }
    objc_setAssociatedObject(actionSheet, &RetainSelfKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return actionSheet;
}

- (UIAlertController *)alertController{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self.title message:self.message preferredStyle:(UIAlertControllerStyle)self.preferredStyle];
    if(self.cancelAction){
        [self._actions addObject:self.cancelAction];
    }
    if(self.destructiveAction){
        [self._actions addObject:self.destructiveAction];
    }
    for(IDAlertAction *IDaction in self._actions){
        UIAlertAction *action = [UIAlertAction actionWithTitle:IDaction.title style:(UIAlertActionStyle)IDaction.style handler:^(UIAlertAction *action) {
            IDAlertAction *underlyinAction = objc_getAssociatedObject(action, &IDAlertActionKey);
            if(underlyinAction){
                if(underlyinAction.handlerBlock){
                    underlyinAction.handlerBlock(underlyinAction);
                }
                objc_setAssociatedObject(action, &IDAlertActionKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }];
        objc_setAssociatedObject(action, &IDAlertActionKey, IDaction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [alertController addAction:action];
    }
    //set options if provided
    if(self.actionSheetOptions[IDAlertControllerActionSheetOptionSourceViewKey]){
        alertController.popoverPresentationController.sourceView = self.actionSheetOptions[IDAlertControllerActionSheetOptionSourceViewKey];
    }
    if(self.actionSheetOptions[IDAlertControllerActionSheetOptionSourceRectKey]){
        alertController.popoverPresentationController.sourceRect = [self.actionSheetOptions[IDAlertControllerActionSheetOptionSourceRectKey] CGRectValue];
    }
    if(self.actionSheetOptions[IDALertControllerActionSheetOptionBarButtonItemKey]){
        alertController.popoverPresentationController.barButtonItem = self.actionSheetOptions[IDALertControllerActionSheetOptionBarButtonItemKey];
    }
    return alertController;
}

#pragma mark - UIAlertView & UIActionSheet delegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self performActionWithButtonIndex:buttonIndex cancelButtonIndex:alertView.cancelButtonIndex destructiveButtonIndex:NSNotFound sender:alertView];
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self performActionWithButtonIndex:buttonIndex cancelButtonIndex:actionSheet.cancelButtonIndex destructiveButtonIndex:actionSheet.destructiveButtonIndex sender:actionSheet];
}

- (void)performActionWithButtonIndex:(NSInteger)buttonIndex cancelButtonIndex:(NSInteger)cancelButtonIndex destructiveButtonIndex:(NSInteger)destructiveIndexButton sender:(id)sender{
    IDAlertAction *action;
    if(buttonIndex == cancelButtonIndex){
        action = self.cancelAction;
    }else if(buttonIndex == destructiveIndexButton){
        action = self.destructiveAction;
    }else{
        for(IDAlertAction *otherAction in self.actions){
            if(otherAction.assignedIndex == buttonIndex){
                action = otherAction;
                break;
            }
        }
    }
    if(action.handlerBlock){
        action.handlerBlock(action);
    }
}

#pragma mark - Display

- (void)show{
    if(![self isAlertControllerAvailable] && self.preferredStyle == IDAlertControllerStyleAlert){
        //display alertView without resolving
        [[self alertView] show];
    }else{
        [self showInViewController:[self topViewController]];
    }
}

- (void)showInViewController:(UIViewController *)viewController{
    [self showInViewController:viewController completion:nil];
}

- (void)showInViewController:(UIViewController *)viewController completion:(void (^)(void))completion{
    if([self isAlertControllerAvailable]){
        [viewController presentViewController:[self alertController] animated:YES completion:completion];
    }else{
        if(self.preferredStyle == IDAlertControllerStyleAlert){
            [[self alertView] show];
        }else{
            [[self actionSheet] showInView:viewController.view];
        }
        if(completion){
            completion();
        }
    }
}

#pragma mark - View controller utils

//top view controller utils
//credit: http://stackoverflow.com/a/17578272/2822938
- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

@end
