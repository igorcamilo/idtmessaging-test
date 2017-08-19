//
//  ViewController.m
//  Question2
//
//  Created by Igor Camilo on 19/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)testString {
    NSString *string = [[[[NSString alloc] init] autorelease] autorelease];
}

- (IBAction)testMyClass {
    MyClass *myclass = [[[[MyClass alloc] init] autorelease] autorelease];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation MyClass

@end
