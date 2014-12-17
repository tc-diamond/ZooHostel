//
//  TCDContactsViewController.m
//  ZooHostel
//
//  Created by Dmitri Doroschuk on 13.07.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDContact.h"
#import "TCDContactCollectionViewCell.h"
#import "TCDContactsViewController.h"
#import <RESideMenu/RESideMenu.h>

@import AddressBook;
@import MapKit;
@import MessageUI;

#define IS_IPHONE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone
#define IS_IPAD UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone

NSString * const kContactsSegueIdentifier = @"ContactsSegueIdentifier";

@interface TCDContactsViewController () <UICollectionViewDelegate, UICollectionViewDataSource, MFMailComposeViewControllerDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBarButton;
@property (copy, nonatomic) NSArray *dataSource;

@end

@implementation TCDContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = [self generateDataSource];
}

#pragma mark - Actions

- (IBAction)addInAddressBook:(id)sender
{
    CFErrorRef error = NULL;
    
    ABAddressBookRef iPhoneAddressBook;
    
    
    iPhoneAddressBook = ABAddressBookCreateWithOptions(NULL, &error);
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(iPhoneAddressBook,  ^(bool granted, CFErrorRef error){
        dispatch_semaphore_signal(sema);
    });
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    ABRecordRef newPerson = ABPersonCreate();
    
    // First Name - Last Name - Nickname - Company Name
    ABRecordSetValue(newPerson, kABPersonFirstNameProperty, @"Наталья", &error);
    ABRecordSetValue(newPerson, kABPersonLastNameProperty, @"Дача-Удача", &error);
    ABRecordSetValue(newPerson, kABPersonOrganizationProperty, @"Зоогостиница", &error);
    
    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(iPhoneAddressBook);
    for (id record in allContacts){
        ABRecordRef thisContact = (__bridge ABRecordRef)record;
        if (CFStringCompare(ABRecordCopyCompositeName(thisContact),
                            ABRecordCopyCompositeName(newPerson), 0) == kCFCompareEqualTo){
            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Ошибка"
                                                           message:@"Пользователь с таким именем уже существует"
                                                          delegate:nil
                                                 cancelButtonTitle:@"Отмена"
                                                 otherButtonTitles:nil];
            [alert show];
            return;
        }
    }

    
    NSString *phone = @"+79500446727"; // the phone number to add
    
    //Phone number is a list of phone number, so create a multivalue
    ABMutableMultiValueRef phoneNumberMultiValue =
    ABMultiValueCreateMutable(kABPersonPhoneProperty);
    ABMultiValueAddValueAndLabel(phoneNumberMultiValue ,(__bridge CFStringRef)(phone),kABPersonPhoneMobileLabel, NULL);
    ABRecordSetValue(newPerson, kABPersonPhoneProperty, phoneNumberMultiValue, &error); // set the phone number property

    
    //  Add Emial addresses
    NSArray *emailAddresses = @[@"dogdacha@gmail.com"];
    ABMutableMultiValueRef multiEmail =ABMultiValueCreateMutable(kABMultiStringPropertyType);
    for (NSString *email in emailAddresses) {
        ABMultiValueAddValueAndLabel(multiEmail, (__bridge CFStringRef)email, kABHomeLabel, NULL);
    }
    ABRecordSetValue(newPerson, kABPersonEmailProperty, multiEmail, &error);
    CFRelease(multiEmail);
    
    //  Adding social and Skype
    ABMultiValueRef social = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
    
    NSDictionary *facebook = [NSDictionary dictionaryWithObjectsAndKeys:
                              (NSString *)kABPersonSocialProfileServiceFacebook,
                              kABPersonSocialProfileServiceKey,
                              @"dogdacha",
                              kABPersonSocialProfileUsernameKey,
                              nil];
    
    ABMultiValueAddValueAndLabel(social,
                                 (__bridge CFTypeRef)(facebook),
                                 kABPersonSocialProfileServiceFacebook, NULL);
    
    ABRecordSetValue(newPerson, kABPersonSocialProfileProperty, social, &error);
    
    // Add an image
    NSData *dataRef = UIImagePNGRepresentation([UIImage imageNamed:@"contact_photo"]);
    ABPersonSetImageData(newPerson, (__bridge CFDataRef)dataRef, &error);
    
    // URL
    NSArray * blogUrls = @[@"http://dogudacha.ru"];
    
    ABMutableMultiValueRef urlMultiValue = ABMultiValueCreateMutable(kABStringPropertyType);
    for (NSString *blogUrl in blogUrls) {
        ABMultiValueAddValueAndLabel(urlMultiValue, (__bridge CFTypeRef)(blogUrl), kABPersonHomePageLabel, NULL);
    }
    
    ABRecordSetValue(newPerson, kABPersonURLProperty, urlMultiValue, &error);
    CFRelease(urlMultiValue);
    
    ABAddressBookAddRecord(iPhoneAddressBook, newPerson, &error);
    ABAddressBookSave(iPhoneAddressBook, &error);
    
    if (error != NULL) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка"
                                                        message:@"Не удается создать пользователя в адресной книге"
                                                       delegate:nil
                                              cancelButtonTitle:@"Отмена"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Пользователь добавлен"
                                                        message:[NSString stringWithFormat:@"%@ была успешно добавлена в адресную книгу.",@"Зоогостиница Дача-Удача"]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    CFRelease(newPerson);
    CFRelease(iPhoneAddressBook);

}

#pragma mark - DataSource

- (NSArray *)generateDataSource
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *phoneNumber = @"tel:+79500446727";
    @weakify(self)
    if ([self canOpenURLString:phoneNumber]) {
        TCDContact *phoneCall = [[TCDContact alloc] initWithTitle:@"Связаться по телефону" imageName:@"phone_icon" actionHandler:^{
            @strongify(self)
            [self openURLString:phoneNumber];
        }];
        [array addObject:phoneCall];
    }
    
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        TCDContact *location = [self locationContact];
        [array addObject:location];
    }
    
    // From within your active view controller
    if([MFMailComposeViewController canSendMail]) {
        TCDContact *mail = [[TCDContact alloc] initWithTitle:@"Отправить e-mail" imageName:@"mail_icon" actionHandler:^{
            @strongify(self)
            MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
            mailCont.mailComposeDelegate = self;
            
            [mailCont setSubject:@"От клиента"];
            [mailCont setToRecipients:[NSArray arrayWithObject:@"dogdacha@gmail.com"]];
            [mailCont setMessageBody:@"" isHTML:NO];
            
            [self presentViewController:mailCont animated:YES completion:nil];
        }];
        [array addObject:mail];
    }
    
    TCDContact *vkGroup = [[TCDContact alloc]initWithTitle:@"Группа VK" imageName:@"vk_icon" actionHandler:^{
        @strongify(self)
        [self openURLString:@"http://vk.com/club23223779"];
    }];
    [array addObject:vkGroup];
    
    TCDContact *vkPhotoGroup = [[TCDContact alloc]initWithTitle:@"Группа VK: Фотографии" imageName:@"vk_icon" actionHandler:^{
        @strongify(self)
        [self openURLString:@"http://vk.com/albums-23223779"];
    }];
    [array addObject:vkPhotoGroup];
    
    
    
    return [array copy];
}

- (TCDContact *)locationContact
{
    return [[TCDContact alloc]initWithTitle:@"Мы на карте" imageName:@"map_icon" actionHandler:^{
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
    }];
}

- (BOOL)canOpenURLString:(NSString *)urlString
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]];
}

- (void)openURLString:(NSString *)urlString
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TCDContact *selectedContact = self.dataSource[indexPath.item];
    if (selectedContact.actionHandler) {
        selectedContact.actionHandler();
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewFlowLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE) {
        return CGSizeMake(150, 150);
    } else {
        return CGSizeMake(250, 250);
    }
}

#pragma mark - UICollerctionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TCDContactCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    TCDContact *currentContact = self.dataSource[indexPath.item];
    cell.imageView.image = [UIImage imageNamed:currentContact.imageName];
    cell.titleLabel.text = currentContact.title;
    
    return cell;
}

#pragma mark - Mail Composer

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation
//
//- (IBAction)menuBarButtonTapped:(id)sender
//{
//    [self.sideMenuViewController presentLeftMenuViewController];
//}

@end
