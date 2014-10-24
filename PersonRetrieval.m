//
//  PersonRetrieval.m
//  Assessment4
//
//  Created by Richmond on 10/24/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "PersonRetrieval.h"

@implementation PersonRetrieval

+ (void)retrieveDogOwners:(void(^)(NSArray *events))complete{
   
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"];
    NSURLRequest *ownerRequest = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:ownerRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *ownerArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (!connectionError)
            {
                complete(ownerArray);
            }else
            {
                complete(nil);
            }
        });
    }];

}



@end
