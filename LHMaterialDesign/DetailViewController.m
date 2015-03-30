//
//  DetailViewController.m
//  LHMaterialDesign
//
//  Created by lihao-xy on 15/3/27.
//  Copyright (c) 2015年 lihao. All rights reserved.
//

#import "DetailViewController.h"
#import "UIViewController+MaterialDesign.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backkButtonPressed:(id)sender {
    [self dismissLHViewControllerWithColor:nil animated:YES completion:^{
        
    }];
}


@end
