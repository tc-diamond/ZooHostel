//
//  UIViewController+BaseExtention.m
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 23.09.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "UIViewController+BaseExtention.h"
#import "objc/runtime.h"
#import <UIViewController+RESideMenu.h>
#import <RESideMenu/RESideMenu.h>

@implementation UIViewController (BaseExtention)

@synthesizeAssociation(UIViewController, backgroundImageView);

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(xxx_viewDidLoad);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)xxx_viewDidLoad
{
    [self xxx_viewDidLoad];
    if ([NSStringFromClass([self class]) isEqualToString:@"TCDMenuViewController"]) {
        return;
    }
    UIScrollView *scrollView;
    
    if ([self respondsToSelector:NSSelectorFromString(@"scrollView")]) {
        SEL scrollSel = NSSelectorFromString(@"scrollView");
        IMP scrollMethod = [self methodForSelector:scrollSel];
        UIScrollView * (*func)(id, SEL) = (void *)scrollMethod;
        scrollView = func(self, scrollSel);
        
        UIImage *image = [UIImage imageNamed:@"Background"];
        //        CGFloat heightByWidth = self.scrollView.contentSize.height / self.scrollView.contentSize.width;
        
        //    CGSize *backgroundSize = CGSizeMake(self.scrollView.contentSize.width, <#CGFloat height#>)
        
        CGFloat scrollHeight = scrollView.bounds.size.height;
        self.backgroundImageView = [[UIImageView alloc]
                                    initWithFrame:CGRectMake(0,
                                                             0,
                                                             scrollView.bounds.size.width,
                                                             scrollHeight + (scrollView.bounds.size.height - scrollHeight) / 2)];
        self.backgroundImageView.image = image;
        //    self.backgroundView.blurRadius = 35;
        [self.view insertSubview:self.backgroundImageView atIndex:0];
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect backgroundRect = self.backgroundImageView.frame;
    CGFloat newY = -scrollView.contentOffset.y / 2;
    if (newY <= 0 && scrollView.bounds.size.height - newY <= self.backgroundImageView.bounds.size.height) {
        backgroundRect.origin.y = newY;
    }
    self.backgroundImageView.frame = backgroundRect;
}

#pragma mark - navigation

- (IBAction)menuBarButtonTapped:(id)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

@end
