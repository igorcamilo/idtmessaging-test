//
//  AppDelegate.m
//  Weather
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import "ICAppDelegate.h"
#import "ICForecast.h"

@interface ICAppDelegate ()

@end

@implementation ICAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[[NSURLSession sharedSession] dataTaskWithURL:[[NSURL alloc] initWithString:@"https://api.openweathermap.org/data/2.5/forecast?lat=-35&lon=-19&lang=fi"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        ICForecast *forecast = [[ICForecast alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        NSLog(@"%@", forecast);
        
    }] resume];
    
    return YES;
}

@end
