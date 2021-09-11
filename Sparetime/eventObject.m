//
//  eventObject.m
//  Sparetime
//
//  Created by Brian Fisher on 2/25/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import "eventObject.h"

@implementation eventObject
@synthesize titleString;
@synthesize start;
@synthesize end;

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.titleString = [decoder decodeObjectForKey:@"title"];
    self.end = [decoder decodeObjectForKey:@"end"];
    self.start = [decoder decodeObjectForKey:@"start"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.titleString forKey:@"title"];
    [encoder encodeObject:self.start forKey:@"start"];
    [encoder encodeObject:self.end forKey:@"end"];

}

@end
