//
//  ViewController.m
//  CrashDemo
//
//  Created by 马扬 on 2016/11/4.
//  Copyright © 2016年 马扬. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 100, 200, 100);
    [button addTarget:self action:@selector(run:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"点击之后数组越界" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor redColor];
    button1.frame = CGRectMake(100, 400, 200, 100);
    [button1 setTitle:@"点击之后弹框" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(run1:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    
}
-(void)run1:(UIButton *)button{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"点击" message:@"button被点击" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)run:(UIButton *)button{
    NSArray * arr=  @[@"1"];;
    NSLog(@"%@",arr[3]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
