//
//  ViewController.m
//  InputToolBar
//
//  Created by kangzhiqiang on 2019/3/15.
//  Copyright © 2019 kangxx. All rights reserved.
//

#import "ViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UISearchBar *searBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth/2-1, 56)];
    searBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:searBar];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth/2-1, 60)];
    textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:textView];
    
    UITextField *tf = [[UITextField alloc] init];
    tf.frame = CGRectMake(0, 300, kScreenWidth/2-1, 44);
    tf.backgroundColor = [UIColor redColor];
    [self.view addSubview:tf];
}


@end
