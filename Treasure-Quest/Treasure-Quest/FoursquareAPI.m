//
//  FoursquareAPI.m
//  Treasure-Quest
//
//  Created by Sean Champagne on 8/6/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "FoursquareAPI.h"
#import "JSONParser.h"
@import UIKit;
@import AFNetworking;

@implementation FoursquareAPI

+(void)getFoursquareData:(NSString *)userData completionHandler:(fourquareFetchCompletion)completionHandler
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormmer = [[NSDateFormatter alloc]init];
    [dateFormmer setDateFormat:@"YYYMMdd"];
    NSString *dateString = [dateFormmer stringFromDate:currDate];
    
    NSString *radius = @"2000";
    NSString *accessToken = @"IPVFQK21YIYRBOAM3JHLKAQXDU2LSDVAUFBLZ1ILNINHBMZY";
    CGFloat latitude = 47.6205;
    CGFloat longitude = -122.3493;
    NSString *latitudeStr = [NSString stringWithFormat:@"%f", latitude];
    NSString *longitudeStr = [NSString stringWithFormat:@"%f", longitude];
    NSMutableString *latitudeLongitudeString = [[NSMutableString alloc]initWithString:latitudeStr];
    [latitudeLongitudeString appendString:longitudeStr];
    NSString *query = @"4d4b7104d754a06370d81259";
    NSString *resultLimit = @"50";
    
    NSString *URLString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%@&query=%@&limit=%@&oauth_token=%@&v=%@",latitudeLongitudeString, query, resultLimit, radius, accessToken, dateString];
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    NSError *error = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if (error != nil)
    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Done"otherButtonTitles:nil];
//        [alert show];
        NSLog(@"%@", [error localizedDescription]);
    } else
    {
//        NSString *jsonString = [[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", jsonString);
//        
//        NSDictionary *parser = [JSONParser dataFromJSON:response];
//        
//        NSDictionary *jsonResponse = (NSDictionary *)parser;
//        NSDictionary *responseData = [[jsonResponse objectForKey:@"response"]objectForKey:@"venues"];
//        NSArray *resultsArray = [responseData valueForKey:@"name"];
//        NSArray *distanceArray = [[responseData valueForKey:@"location"]valueForKey:@"distance"];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager GET:response parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
            //
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSArray *results = [JSONParser dataFromJSON:responseObject];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(results, nil);
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            
        }];
    }
}

@end
