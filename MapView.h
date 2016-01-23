//
//  MapView.h
//  pushCalendar
//
//  Created by iosdev on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mapAnnotation.h"
#import<MapKit/MapKit.h>


@interface MapView : UIViewController<MKMapViewDelegate, NSXMLParserDelegate>{
	IBOutlet UITextField *addressField;
    IBOutlet UITextField *addressFieldTo;
	IBOutlet UIButton *goButton;
	IBOutlet MKMapView *mapView;
	NSXMLParser *xmlParser;
	mapAnnotation *addAnnotation;
    CLLocationCoordinate2D doit;
    int secondcords;
    int legs;
    NSString *elementname;
    NSString *x;
    NSString *y;
    NSString *as;
    NSMutableArray *xArray;
    NSMutableArray *yArray;
    NSMutableString *putcoordstogether;
    NSMutableArray *bothCoordinates;
    NSMutableArray *bothCoordsTogether;
    NSMutableString *coords1;
    NSMutableString *coords2;
    NSMutableString *something;
    BOOL boolean;
    NSMutableArray *overLays;
    MKMapView* _mapView;
    // the data representing the route points. 
	MKPolyline* _routeLine;
    NSArray *endAndStartAnnotation;
	
    
	// the view we create for the line on the map
	MKPolylineView* _routeLineView;
	
	// the rect that bounds the loaded points
	MKMapRect makeRectangleAroundRoute;
}
@property (nonatomic, strong) MKPolyline* routeLine;
@property (nonatomic, strong) MKPolylineView* routeLineView;
@property (nonatomic, strong) IBOutlet MKMapView* mapView;
- (IBAction) showAddress;
-(void) loadRoute;
// use the computed _routeRect to zoom in on the route. 
-(void) zoomInOnRoute;

-(CLLocationCoordinate2D) addressLocation;

@end
