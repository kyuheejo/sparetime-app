//
//  activityObject.m
//  Sparetime
//
//  Created by Brian Fisher on 2/26/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import "activityObject.h"

@implementation activityObject

@synthesize titleString;
@synthesize descriptionString;
@synthesize typeString;
@synthesize locationString;
@synthesize startDate;
@synthesize endDate;
@synthesize picture;
@synthesize imageNamed;
@synthesize eventId;
@synthesize appleCalId;
@synthesize priceString;
@synthesize numClicks;
@synthesize tagString;




- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.titleString = [decoder decodeObjectForKey:@"titleString"];
    self.descriptionString = [decoder decodeObjectForKey:@"descriptionString"];
    self.typeString = [decoder decodeObjectForKey:@"typeString"];
    self.locationString = [decoder decodeObjectForKey:@"locationString"];
    self.startDate = [decoder decodeObjectForKey:@"startDate"];
    self.endDate = [decoder decodeObjectForKey:@"endDate"];
    self.picture = [decoder decodeObjectForKey:@"picture"];
    self.imageNamed = [decoder decodeObjectForKey:@"imageNamed"];
    self.eventId = [decoder decodeObjectForKey:@"eventId"];
    self.appleCalId = [decoder decodeObjectForKey:@"appleCalId"];
    self.priceString = [decoder decodeObjectForKey:@"priceString"];
    self.urlString = [decoder decodeObjectForKey:@"urlString"];
    self.numClicks = [decoder decodeObjectForKey:@"numClicks"];
    self.tagString = [decoder decodeObjectForKey:@"tagString"];


    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.titleString forKey:@"titleString"];
    [encoder encodeObject:self.descriptionString forKey:@"descriptionString"];
    [encoder encodeObject:self.typeString forKey:@"typeString"];

    [encoder encodeObject:self.locationString forKey:@"locationString"];
    [encoder encodeObject:self.startDate forKey:@"startDate"];
    [encoder encodeObject:self.endDate forKey:@"endDate"];
    [encoder encodeObject:self.picture forKey:@"picture"];
    [encoder encodeObject:self.imageNamed forKey:@"imageNamed"];
    [encoder encodeObject:self.eventId forKey:@"eventId"];
    [encoder encodeObject:self.appleCalId forKey:@"appleCalId"];
    [encoder encodeObject:self.priceString forKey:@"priceString"];
    [encoder encodeObject:self.urlString forKey:@"urlString"];
    [encoder encodeObject:self.numClicks forKey:@"numClicks"];
    [encoder encodeObject:self.tagString forKey:@"tagString"];


    
}


@end
