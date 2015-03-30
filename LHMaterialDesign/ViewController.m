//
//  ViewController.m
//  LHMaterialDesign
//
//  Created by lihao-xy on 15/3/27.
//  Copyright (c) 2015年 lihao. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+MaterialDesign.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickButtonPressed:(id)sender{
    [self presentLHViewController:[DetailViewController alloc] view:sender color:nil animated:YES completion:^{
        
    }];
}

@end
