//
//  ICForecastItem.h
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICForecastItem : NSObject

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, copy) NSString *valueText;

- (instancetype)initWithLabelText:(NSString *)labelText valueText:(NSString *)valueText;

@end
