//
//  UISearchBar+ToolBar.m
//  RAC测试
//
//  Created by kangzhiqiang on 2019/3/14.
//  Copyright © 2019 kangxx. All rights reserved.
//

#import "UISearchBar+ToolBar.h"
#import <objc/runtime.h>

@implementation UISearchBar (ToolBar)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchangeWithOriginMethod:@selector(awakeFromNib) withNewMethod:@selector(kk_awakeFromNib)];
        [self exchangeWithOriginMethod:@selector(initWithFrame:) withNewMethod:@selector(kk_initWithFrame:)];
    });
}
- (instancetype)kk_initWithFrame:(CGRect)frame{
    [self addToolBar];
    return [self kk_initWithFrame:frame];
}
- (void)kk_awakeFromNib{
    [self addToolBar];
    [self kk_awakeFromNib];
}
//取消焦点
- (void)textFieldDone{
    [self resignFirstResponder];
}
//交换方法
+ (void)exchangeWithOriginMethod:(SEL)originMethSel withNewMethod:(SEL)newMethSel{
    Method originMeth = class_getInstanceMethod([self class], originMethSel);
    Method newMeth = class_getInstanceMethod([self class], newMethSel);
    IMP originIMP = method_getImplementation(originMeth);
    IMP newIMP = method_getImplementation(newMeth);
    
    BOOL isAdd = class_addMethod([self class],originMethSel, newIMP, method_getTypeEncoding(newMeth));
    if (isAdd) {
        class_replaceMethod([self class], newMethSel, originIMP, method_getTypeEncoding(originMeth));
    }else{
        method_exchangeImplementations(originMeth, newMeth);
    }
}
//添加done按钮的toolbar
- (void)addToolBar{
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width,44)];
    self.inputAccessoryView = bar;
    [bar layoutIfNeeded];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 60, 7,50, 30)];
    [button setTitle:@"Done"forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [bar addSubview:button];
    [button addTarget:self action:@selector(textFieldDone)forControlEvents:UIControlEventTouchUpInside];
}
@end
