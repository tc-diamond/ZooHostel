//
//  TCDScrollableViewController.h
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 21.09.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCDScrollableViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end
