//
//  TCDProgramTypesViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 19.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDProgramTypesViewController.h"
#import <RESideMenu/RESideMenu.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

NSString * const kProgramTypesSegueIdentifier = @"ProgramTypesSegueIdentifier";

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (IBAction)menuBarButtonTapped:(id)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end