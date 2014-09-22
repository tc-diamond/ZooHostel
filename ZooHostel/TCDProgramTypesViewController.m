//
//  TCDProgramTypesViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 19.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDProgramTypesViewController.h"
#import "TCDCrewViewController.h"
#import <RESideMenu/RESideMenu.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

NSString * const TCDProgramTypesViewControllerIdentifier = @"ProgramTypesSegueIdentifier";

@interface TCDProgramTypesViewController ()

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *contactVKLabel;

@end

@implementation TCDProgramTypesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSRange range = [self.contactVKLabel.text rangeOfString:@"группе вконтакте"];
    [self.contactVKLabel addLinkToURL:[NSURL URLWithString:@"http://vk.com/topic-23223779_28952848"] withRange:range];
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([scrollView scrolledToBottom])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Наша команда" style:UIBarButtonItemStylePlain target:self action:@selector(crew)];
    }
}

- (void)crew
{
    self.sideMenuViewController.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:TCDCrewViewControllerIdentifier];
}

@end
