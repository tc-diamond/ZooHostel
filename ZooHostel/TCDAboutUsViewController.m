//
//  TCDAboutUsViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 19.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDAboutUsViewController.h"
#import "TCDProgramTypesViewController.h"
#import <RESideMenu/RESideMenu.h>
@import MapKit;

NSString * const TCDAboutUsViewControllerIdentifier = @"AboutUsSegueIdentifier";

@interface TCDAboutUsViewController ()

@property (nonatomic, strong) UIBarButtonItem *ourLocationBarButtonItem;

@end

@implementation TCDAboutUsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.ourLocationBarButtonItem = self.navigationItem.rightBarButtonItem;
    // Do any additional setup after loading the view.
}

- (IBAction)ourLocation:(id)sender
{
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:@"деревня Вартемяги, Ленинградская область, Россия"
                     completionHandler:^(NSArray *placemarks, NSError *error) {
                         
                         // Convert the CLPlacemark to an MKPlacemark
                         // Note: There's no error checking for a failed geocode
                         CLPlacemark *geocodedPlacemark = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc]
                                                   initWithCoordinate:geocodedPlacemark.location.coordinate
                                                   addressDictionary:geocodedPlacemark.addressDictionary];
                         
                         // Create a map item for the geocoded address to pass to Maps app
                         MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
                         [mapItem setName:geocodedPlacemark.name];
                         
                         // Set the directions mode to "Driving"
                         // Can use MKLaunchOptionsDirectionsModeWalking instead
                         NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
                         
                         // Get the "Current User Location" MKMapItem
                         MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
                         
                         // Pass the current location and destination map items to the Maps app
                         // Set the direction mode in the launchOptions dictionary
                         [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem] launchOptions:launchOptions];
                         
                     }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Не удается открыть карты Apple" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView scrolledToBottom]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Виды путевок" style:UIBarButtonItemStyleBordered target:self action:@selector(programTypes)];
    } else {
        self.navigationItem.rightBarButtonItem = self.ourLocationBarButtonItem;
    }
}

- (void)programTypes
{
    self.sideMenuViewController.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:TCDProgramTypesViewControllerIdentifier];
}

@end
