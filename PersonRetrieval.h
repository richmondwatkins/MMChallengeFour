//
//  PersonRetrieval.h
//  Assessment4
//
//  Created by Richmond on 10/24/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonRetrieval : NSObject


+ (void)retrieveDogOwners:(void(^)(NSArray *people))complete;


@end
