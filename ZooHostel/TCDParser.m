//
//  TCDParser.m
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 26.08.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//

#import "TCDParser.h"
#import "TCDPhoto.h"
#import "TCDPhotoAlbum.h"
@import CoreImage;

@implementation TCDParser

+ (NSArray *)parseStringToPhotoAlbums:(NSString *)parsingString
{
    NSMutableArray *photoAlbums = [NSMutableArray array];
    parsingString = [parsingString stringByReplacingOccurrencesOfString:@"\r" withString:@""];

    NSArray *components = [parsingString componentsSeparatedByString:@"\n"];
    
    TCDPhotoAlbum *photoAlbum;
    TCDPhoto *photo;
    
    for (NSString *componentItem in components) {
        NSString *component = [componentItem copy];
        if (component.length == 0) {
            continue;
        }
        NSString *componentWithNoFirstSign = [component stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        
        if ([component hasPrefix:@"+"]) {
            if (photoAlbum) {
                [photoAlbums addObject:photoAlbum];
            }
            photoAlbum = [TCDPhotoAlbum new];
            photoAlbum.title = componentWithNoFirstSign;
        } else {
            CGSize size = [self getSizeFromUrlString:&component];

            if (CGSizeEqualToSize(size, CGSizeZero)) {
                continue;
            }
            if ([component hasPrefix:@"-"]) {
                photo = [TCDPhoto new];
                photo.url = [NSURL URLWithString:componentWithNoFirstSign];
            } else if ([component hasPrefix:@"_"]) {
                photo.presentationUrl = [NSURL URLWithString:componentWithNoFirstSign];
                if (photo) {
                    [photoAlbum.photos addObject:photo];
                }
            }
        }
    }
    
    //adding last photoAlbum
    if (photoAlbum) {
        [photoAlbums addObject:photoAlbum];
    }
    
    return [photoAlbums copy];
}

+ (CGSize)getSizeFromUrlString:(NSString **)urlString
{
    CGSize size;
    NSArray *componentsByPlusSign = [*urlString componentsSeparatedByString:@"="];
    if ([componentsByPlusSign count] != 3) {
        return CGSizeZero;
    }
    *urlString = componentsByPlusSign[0];
    size.width = [componentsByPlusSign[1] floatValue];
    return size;
}

@end
