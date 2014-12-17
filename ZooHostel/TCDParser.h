//
//  TCDParser.h
//  ZooHostel
//
//  Created by Дорощук Дмитрий on 26.08.14.
//  Copyright (c) 2014 Dmitri Doroschuk. All rights reserved.
//  Логика реализована не с точки зрения правильности, фэн-шуя и укоряющих взглядов других разработчиков. Она реализована для удобства изменения заказчиком на сервере.
//

#import <Foundation/Foundation.h>

//format of string: {+-_}http://photo.com/photoid=width=height

@interface TCDParser : NSObject

+ (NSArray *)parseStringToPhotoAlbums:(NSString *)parsingString;
+ (NSArray *)photosFromParsingString:(NSString *)string;

@end
