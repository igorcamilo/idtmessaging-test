//
//  ICCity.h
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ICCity : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *countryCode;

@end
