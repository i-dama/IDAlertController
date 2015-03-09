# IDAlertController

[![Version](https://img.shields.io/cocoapods/v/IDAlertController.svg?style=flat)](http://cocoadocs.org/docsets/IDAlertController)
[![License](https://img.shields.io/cocoapods/l/IDAlertController.svg?style=flat)](http://cocoadocs.org/docsets/IDAlertController)
[![Platform](https://img.shields.io/cocoapods/p/IDAlertController.svg?style=flat)](http://cocoadocs.org/docsets/IDAlertController)

iOS7-safe UIAlertController

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

------
IDAlertController uses UIAlertController-like syntax:

```Objective-C
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

```

## Requirements
* ARC

## Installation

IDAlertController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "IDAlertController"

## Author

Ivan Damjanović, ivan.damjanovic@infinum.hr

[More cool stuff](http://www.infinum.co)

## License

IDAlertController is available under the MIT license. See the LICENSE file for more info.

