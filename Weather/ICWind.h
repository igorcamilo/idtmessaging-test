//
//  ICWind.h
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICWind : NSObject

@property (nonatomic, copy) NSMeasurement<NSUnitSpeed *> *speed;
@property (nonatomic, copy) NSMeasurement<NSUnitAngle *> *degrees;

@end
