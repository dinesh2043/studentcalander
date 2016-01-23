//
//  mapAnnotation.h
//  pushCalendar
//
//  Created by iosdev on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<MapKit/MapKit.h>

@interface mapAnnotation : NSObject<MKAnnotation, NSXMLParserDelegate> {
	CLLocationCoordinate2D coordinate;
	NSString *mTitle;
	NSString *mSubTitle;
    NSString *endOrStart;
}
@property (nonatomic,strong) NSString *endOrStart;
-(id)initWithCoordinate:(CLLocationCoordinate2D) c
                  title:(NSString *)aTitle
             endOrStart:(NSString *)endorstart;
@end
