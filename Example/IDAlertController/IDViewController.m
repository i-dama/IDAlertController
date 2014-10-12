//
//  IDViewController.m
//  IDAlertController
//
//  Created by Ivan Damjanović on 10/12/2014.
//  Copyright (c) 2014 Ivan Damjanović. All rights reserved.
//

#import "IDViewController.h"
#import <IDAlertController/IDAlertController.h>

@interface IDViewController ()

@end

@implementation IDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert:(id)sender {
    IDAlertController *alertController = [IDAlertController alertControllerWithTitle:@"Hello world" message:@"This is a sample message" preferredStyle:IDAlertControllerStyleAlert];
    [alertController addActionWithTitle:@"Cancel" style:IDAlertActionStyleCancel handler:^(IDAlertAction *action) {
        NSLog(@"Cancel");
    }];
    [alertController addActionWithTitle:@"OK" style:IDAlertActionStyleDefault handler:^(IDAlertAction *action) {
        NSLog(@"OK");
    }];
    [alertController show];
}

- (IBAction)showActionSheet:(id)sender {
    IDAlertController *alertController = [IDAlertController alertControllerWithTitle:@"Hello world" message:nil preferredStyle:IDAlertControllerStyleActionSheet];
    [alertController addActionWithTitle:@"Cancel" style:IDAlertActionStyleCancel handler:^(IDAlertAction *action) {
        NSLog(@"Cancel");
    }];
    [alertController addActionWithTitle:@"Destructive" style:IDAlertActionStyleDestructive handler:^(IDAlertAction *action) {
        NSLog(@"Destructive");
    }];
    [alertController addActionWithTitle:@"Option one" style:IDAlertActionStyleDefault handler:^(IDAlertAction *action) {
        NSLog(@"Option one");
    }];
    [alertController addActionWithTitle:@"Option two" style:IDAlertActionStyleDefault handler:^(IDAlertAction *action) {
        NSLog(@"Option two");
    }];
    [alertController show];
}
@end
