//
//  mapAnnotation.m
//  pushCalendar
//
//  Created by iosdev on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "mapAnnotation.h"
@implementation mapAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize endOrStart;


-(id)initWithCoordinate:(CLLocationCoordinate2D) c
                  title:(NSString *)aTitle
             endOrStart:(NSString *)endorstart{
	coordinate=c;
    title = aTitle;
    endOrStart = endorstart;
	//NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

@end
