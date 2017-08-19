//
//  ICForecastTableViewModel.m
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import "ICForecastTableViewModel.h"
#import "ICForecastContainer.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ICForecastTableViewModel () <CLLocationManagerDelegate>

@property (nonatomic, getter=isDownloading) BOOL downloading;
@property (nonatomic, strong) NSArray<ICForecast *> *forecastList;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ICForecastTableViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.downloading = NO;
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)update {
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
            [self.locationManager requestLocation];
            break;
            
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            break;
            
        default:
            [self.delegate forecastTableViewModel:self updateDidFailWithError:[NSError errorWithDomain:kCLErrorDomain code:status userInfo:@{NSLocalizedDescriptionKey: @"Can't get user location"}]];
            break;
    }
}

- (void)downloadForecastInfoForCoordinate:(CLLocationCoordinate2D)coordinate {
    
    if (self.isDownloading) {
        return;
    }
    
    self.downloading = YES;
    // Building the URL
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:@"https://api.openweathermap.org/data/2.5/forecast"];
    NSURLQueryItem *latQuery = [NSURLQueryItem queryItemWithName:@"lat" value:[NSString stringWithFormat:@"%f", coordinate.latitude]];
    NSURLQueryItem *lonQuery = [NSURLQueryItem queryItemWithName:@"lon" value:[NSString stringWithFormat:@"%f", coordinate.longitude]];
    NSURLQueryItem *langQuery = [NSURLQueryItem queryItemWithName:@"lang" value:[NSLocale currentLocale].languageCode];
    NSURLQueryItem *appidQuery = [NSURLQueryItem queryItemWithName:@"appid" value:<#API Key#>];
    urlComponents.queryItems = @[latQuery, lonQuery, langQuery, appidQuery];
    // Making the request
    [[[NSURLSession sharedSession] dataTaskWithURL:urlComponents.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.downloading = NO;
        
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate forecastTableViewModel:self updateDidFailWithError:error];
            });
            return;
        }
        
        ICForecastContainer *forecast = [[ICForecastContainer alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        self.forecastList = forecast.list;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate forecastTableViewModelUpdateDidSucceed:self];
        });
        
    }] resume];
}

- (NSInteger)numberOfSections {
    return self.forecastList.count;
}

- (NSInteger)numberOfRowsForSection:(NSInteger)section {
    return self.forecastList[section].items.count;
}

- (NSString *)titleForSection:(NSInteger)section {
    return self.forecastList[section].dateString;
}

- (ICForecastItem *)forecastItemForIndexPath:(NSIndexPath *)indexPath {
    return self.forecastList[indexPath.section].items[indexPath.row];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self update];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self downloadForecastInfoForCoordinate:locations.lastObject.coordinate];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.delegate forecastTableViewModel:self updateDidFailWithError:error];
}

@end
