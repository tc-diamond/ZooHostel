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
        
        if ([component hasPrefix:@"+"] || photoAlbums.count == 0) {
            if (photoAlbum) {
                [photoAlbums addObject:photoAlbum];
            }
            photoAlbum = [TCDPhotoAlbum new];
            photoAlbum.title = componentWithNoFirstSign;
        } else {
            CGSize size = [self getSizeFromUrlString:&component];
            componentWithNoFirstSign = [component stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
            if (CGSizeEqualToSize(size, CGSizeZero)) {
                continue;
            }
            if ([component hasPrefix:@"-"]) {
                photo = [TCDPhoto new];
                photo.url = [NSURL URLWithString:componentWithNoFirstSign];
                photo.size = size;
            } else if ([component hasPrefix:@"_"]) {
                photo.presentationUrl = [NSURL URLWithString:componentWithNoFirstSign];
                photo.size = size;
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

+ (NSArray *)photosFromParsingString:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSArray *components = [string componentsSeparatedByString:@"\n"];
    

    NSMutableArray *photos = [NSMutableArray array];
    TCDPhoto *photo;
    
    for (NSString *componentItem in components) {
        NSString *component = [componentItem copy];
        if (component.length == 0) {
            continue;
        }
        NSString *componentWithNoFirstSign = [component stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        
        photo = [TCDPhoto new];
        CGSize size = [self getSizeFromUrlString:&component];
        photo.size = size;
        photo.url = [NSURL URLWithString:componentWithNoFirstSign];
        [photos addObject:photo];
    }

    return photos;
}

+ (CGSize)getSizeFromUrlString:(NSString **)urlString
{
    CGSize size;
    NSArray *componentsByEqualSign = [*urlString componentsSeparatedByString:@"="];
    if ([componentsByEqualSign count] != 3) {
        return CGSizeZero;
    }
    *urlString = componentsByEqualSign[0];
    size.width = [componentsByEqualSign[1] floatValue];
    size.height = [componentsByEqualSign[2] floatValue];
    
    return size;
}

@end
