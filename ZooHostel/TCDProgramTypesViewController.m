//
//  TCDProgramTypesViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 19.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDProgramTypesViewController.h"
#import "TCDCrewViewController.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>

NSString * const TCDProgramTypesViewControllerIdentifier = @"ProgramTypesSegueIdentifier";

@interface TCDProgramTypesViewController () <UIActionSheetDelegate, TTTAttributedLabelDelegate>

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *contactVKLabel;

@end

@implementation TCDProgramTypesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSRange range = [self.contactVKLabel.text rangeOfString:@"группе вконтакте"];
    self.contactVKLabel.delegate = self;
    [self.contactVKLabel addLinkToURL:[NSURL URLWithString:@"https://vk.com/topic-23223779_28952848"] withRange:range];
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
    [((TCDSideMenu *)self.sideMenuViewController) nextTableSelection];
    self.sideMenuViewController.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:TCDCrewViewControllerIdentifier];
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url {
    [[[UIActionSheet alloc] initWithTitle:@"Группа Зоогостиницы Дача-Удача в vk.com" delegate:self cancelButtonTitle:@"Отмена" destructiveButtonTitle:nil otherButtonTitles:@"Открыть в Safari", nil] showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:actionSheet.title]];
}

@end
