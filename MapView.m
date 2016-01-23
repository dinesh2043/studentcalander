//
//  MapView.m
//  pushCalendar
//
//  Created by iosdev on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapView.h"
#import "mapAnnotation.h"


@implementation MapView
@synthesize routeLine = _routeLine;
@synthesize routeLineView = _routeLineView;
@synthesize mapView = _mapView;


-(IBAction)back
{
    [self dismissModalViewControllerAnimated:YES];
}

//Hides the keyboard when 'go' button is pressed
-(IBAction)HideKeyBoard:(id)sender{
    [addressField resignFirstResponder];
    [addressFieldTo resignFirstResponder];
}

-(void) loadRoute{
    
    
	
	MKMapPoint northEastPoint; 
	MKMapPoint southWestPoint; 
	
    //    NSLog(@"coordinates: %@", bothCoordsTogether);
    NSLog(@"Count of the coordinates: %i",[bothCoordsTogether count]);
	// create an array of points. 
	MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * bothCoordsTogether.count);
	
	for(int idx = 0; idx < bothCoordsTogether.count; idx++)
	{
        
		NSString* currentPointString = [bothCoordsTogether objectAtIndex:idx];
		NSArray* latitudeLongitudeArray = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
		CLLocationDegrees longitude  = [[latitudeLongitudeArray objectAtIndex:0] doubleValue];
		CLLocationDegrees latitude = [[latitudeLongitudeArray objectAtIndex:1] doubleValue];
        //        NSLog(@"latitude: %f",latitude);
        //        NSLog(@"longitude: %f",longitude);
        //        NSLog(@"counter: %i",idx);
        
		CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
		MKMapPoint point = MKMapPointForCoordinate(coordinate);
        
        
        
		if (idx == 0) {
			northEastPoint = point;
			southWestPoint = point;
		}
		else 
		{
			if (point.x > northEastPoint.x) 
				northEastPoint.x = point.x;
			if(point.y > northEastPoint.y)
				northEastPoint.y = point.y;
			if (point.x < southWestPoint.x) 
				southWestPoint.x = point.x;
			if (point.y < southWestPoint.y) 
				southWestPoint.y = point.y;
		}
        
		pointArr[idx] = point;
        
	}
    
    // create the polyline from the coordinate array
	self.routeLine = [MKPolyline polylineWithPoints:pointArr count:bothCoordsTogether.count];
    
	makeRectangleAroundRoute = MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y);
    
	free(pointArr);
    
    
}
-(void) zoomInOnRoute
{
	[self.mapView setVisibleMapRect:makeRectangleAroundRoute animated:TRUE];
    
    
}

// This method is called if you use addOverlay. Must be called by delegate?
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
	MKOverlayView* overlayView = nil;
    
	if(overlay == self.routeLine)
	{
		
		if(nil == self.routeLineView)
		{
			self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
            self.routeLineView.lineWidth = 3;
			self.routeLineView.fillColor = [UIColor blackColor];
			self.routeLineView.strokeColor = [UIColor redColor];
            self.routeLineView.lineCap = kCGLineCapRound;
			
		}
		
		overlayView = self.routeLineView;
        
	}
	return overlayView;
}

- (IBAction) showAddress {
    
    //all the hassle with xml,reittiopas etc
    [self addressLocation];
    
    //Hide the keypad
	[addressField resignFirstResponder];
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=0.2;
	span.longitudeDelta=0.2;
	
    //	CLLocationCoordinate2D location = [self addressLocation];
	region.span=span;
	region.center=doit;
	
    //removes the annotations if there is annotations
    if (endAndStartAnnotation != nil) {
        [_mapView removeAnnotations:endAndStartAnnotation];
        endAndStartAnnotation = nil;
    }
    
    
    NSArray* startAnno = [[bothCoordsTogether objectAtIndex:0] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
    CLLocationDegrees longitude  = [[startAnno objectAtIndex:0] doubleValue];
    CLLocationDegrees latitude = [[startAnno objectAtIndex:1] doubleValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    mapAnnotation *startAnnotation  = [[mapAnnotation alloc]initWithCoordinate:coordinate title:addressField.text endOrStart:@"leStart"];
    
    
    NSArray* endAnno = [[bothCoordsTogether lastObject] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
    CLLocationDegrees endlongitude  = [[endAnno objectAtIndex:0] doubleValue];
    CLLocationDegrees endlatitude = [[endAnno objectAtIndex:1] doubleValue];
    CLLocationCoordinate2D endcoordinate = CLLocationCoordinate2DMake(endlatitude, endlongitude);
    mapAnnotation *endAnnotation  = [[mapAnnotation alloc]initWithCoordinate:endcoordinate title:addressFieldTo.text endOrStart:@"leEnd"];
    
    //put the start and end annotations to an array and add the annotations
    endAndStartAnnotation=[NSArray arrayWithObjects:startAnnotation,endAnnotation, nil];
    [self.mapView addAnnotations:endAndStartAnnotation];
    
    //This one creates the points for the route and line from the points
    [self loadRoute];
    //zooms the map on the route
    [self zoomInOnRoute];
    
    //if there is array with something in it remove it and overlay
    if (overLays!=nil) {
        [_mapView removeOverlays:[overLays objectAtIndex:0]];
        [overLays removeAllObjects];
    }
    
    //Add overlay on map with the route
    [self.mapView addOverlay:self.routeLine];
    
    
    //if there isn't array, make one
    if (!overLays) {
        overLays = [[NSMutableArray alloc]init];
    }
    
    //add overlay to array so it can be deleted easily
    [overLays addObject:[_mapView overlays]];
    
    
    
    NSLog(@"Count of the overlays: %i",_mapView.overlays.count);
    
    
    xmlParser=nil;
    secondcords=0;
    legs=0;
    elementname=nil;
    x=nil;
    y=nil;
    as=nil;
    xArray=nil;
    yArray=nil;
    putcoordstogether=nil;
    bothCoordinates=nil;
    bothCoordsTogether=nil;
    coords1=nil;
    coords2=nil;
    something=nil;
    _routeLineView=nil;
    
    
    
    
    
    
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    
    //-------PARSING THE XML GOTTEN FROM REITTIOPAS WHEN DOING THE SEARCH--------
    if([elementName isEqualToString:@"coords"]&&(secondcords!=2)) {
        elementname = elementName;
        //        NSLog(@"my element %@",moi);
    }
    if ([elementName isEqualToString:@"coords"]&&(secondcords==2)) {
        elementname=elementName;
    }
    //--------------------------------------------------------------------------
    
    
    
    
    
    //--------PARSING THE XML TO GET THE COORDINATES FOR DRAWING THE ROUTE-------
    
    
    if ([elementName isEqualToString:@"x"]&&(boolean==YES)) {
        x=elementName;
    }
    
    if ([elementName isEqualToString:@"y"]&&(boolean==YES)) {
        y=elementName;
    }
    if ([elementName isEqualToString:@"shape"]) {
        boolean = YES;
    }
    
    //--------------------------------------------------------------------------
    
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    //-------PARSING THE XML GOTTEN FROM REITTIOPAS WHEN DOING THE SEARCH--------
    if([elementname isEqualToString:@"coords"]&&(secondcords!=2)){
        coords1 = [[NSMutableString alloc] initWithString:string];
    }
    if ([elementname isEqualToString:@"coords"]&&(secondcords==2)) {
        coords2 = [[NSMutableString alloc] initWithString:string];
    }
    //--------------------------------------------------------------------------
    
    
    
    
    //--------PARSING THE XML TO GET THE COORDINATES FOR DRAWING THE ROUTE-------
    
    if ([x isEqualToString:@"x"]&&(legs!=1)&&(boolean==YES)) {
        if (!xArray) {
            xArray=[[NSMutableArray alloc]init];
        }
        if (!bothCoordinates) {
            bothCoordinates=[[NSMutableArray alloc]init];
        }
        if (!bothCoordsTogether) {
            bothCoordsTogether=[[NSMutableArray alloc]init];
        }
        if (!putcoordstogether) {
            putcoordstogether=[[NSMutableString alloc]init];
        }
        if (!something) {
            something=[[NSMutableString alloc]init];
        }
        [something appendString:@"#"];
        [something appendString:string];
        [something appendString:@","];
        [bothCoordinates addObject:string];
        [xArray addObject:string];
        [putcoordstogether appendString:string];
        [putcoordstogether appendString:@","];
        
        x=nil;
    }
    
    if ([y isEqualToString:@"y"]&&(legs!=1)&&(boolean==YES)) {
        //        NSLog(@"koordiy: %@",string);
        if (!yArray) {
            yArray=[[NSMutableArray alloc]init];
        }
        [bothCoordinates addObject:string];
        [yArray addObject:string];
        [something appendString:string];
        [putcoordstogether appendString:string];
        
        if (!bothCoordsTogether) {
            bothCoordsTogether=[[NSMutableArray alloc]init];
        }
        [bothCoordsTogether addObject:putcoordstogether];
        putcoordstogether=nil;
        y=nil;
    }
    //--------------------------------------------------------------------------
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"shape"]) {
        boolean=NO;
    }
    if([elementName isEqualToString:@"coords"]){
        elementname=@"perkele";
        secondcords = 2;
        return;
    }
    if ([elementName isEqualToString:@"legs"]) {
        legs=1;
    }
    else{
        //         NSLog(@"Processing Value: %@", coords1);
    }
}
-(CLLocationCoordinate2D) addressLocation {
    
    
    
    //PLAY AROUND
    //	NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false",[addressField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    // REITTIOPAS
    //    NSString *urlString = [NSString stringWithFormat:@"http://api.reittiopas.fi/public-ytv/fi/api/?a=2546445,6675512&b=2549445,6675513&user=neo_ati&pass=vumi_18", 
    //                           [addressField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    /*
     //WORKING SEARCH URL
     NSString *urlString1 = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv&key=ABQIAAAAaADmVtj_-nmhXjIl1g9WGRSL2BzfO-xG5dMxRVE_rQHqWh1JyBS5F3N3QoT9NYgVS7Wf1TytsQKZ_w", 
     [addressField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
     
     NSString *urlString2 = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv&key=ABQIAAAAaADmVtj_-nmhXjIl1g9WGRSL2BzfO-xG5dMxRVE_rQHqWh1JyBS5F3N3QoT9NYgVS7Wf1TytsQKZ_w", 
     [addressFieldTo.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
     
     
     */
    
    //    http://api.reittiopas.fi/public-ytv/fi/api/?a=2546445,6675512&b=2549445,6675513&user=nano&pass=test
    //    /public-ytv/fi/api/?a=2546445,6675512&b=2549445,6675513&user=neo_ati&pass=vumi_18
    
    
    /*
     NSString *locationString1 = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString1]];
     NSString *locationString2 = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString2]];
     NSLog(@"perse1: %@",locationString1);
     NSLog(@"perse2: %@",locationString2);
     */
    
    
    // Build the string with 'from' input field
    NSString *urlString1 = [NSString stringWithFormat:@"http://api.reittiopas.fi/hsl/prod/?request=geocode&key=%@&user=neo_ati&pass=vumi_18&format=xml&epsg_out=4326", 
                            [addressField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    // build the string with 'to" input field
    NSString *urlString2 = [NSString stringWithFormat:@"http://api.reittiopas.fi/hsl/prod/?request=geocode&key=%@&user=neo_ati&pass=vumi_18&format=xml&epsg_out=4326", 
                            [addressFieldTo.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    //    NSLog(@"from: %@",urlString1);
    //    NSLog(@"to: %@",urlString2);
    
    
    
    BOOL success;
    // init and alloc nsurl with the 'from' string and get the content of it, then parse it with xml parser
    NSURL *url1 = [[NSURL alloc] initWithString:urlString1];
    xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url1];
    [xmlParser setDelegate:self];
    success=[xmlParser parse];
    
    // init and alloc nsurl with the 'to' string and get the content of it, then parse it with xml parser
    NSURL *url2 = [[NSURL alloc]initWithString:urlString2];
    xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url2];
    [xmlParser setDelegate:self];
    success=[xmlParser parse];
    
    
    
    //    NSLog(@"From coords: %@",coords1);
    //    NSLog(@"To coords: %@",coords2);
    
    NSArray *listItems1 = [coords1 componentsSeparatedByString:@","];
    NSArray *listItems2 = [coords2 componentsSeparatedByString:@","];
    coords1=nil;
    coords2=nil;
    elementname=nil;
    secondcords=0;
    
    
	
	double latitude = 0;
	double longitude = 0;
    double latitude2 = 0;
	double longitude2 = 0;
	
	if([listItems1 count] >= 2) {
		longitude = [[listItems1 objectAtIndex:0] doubleValue];
		latitude = [[listItems1 objectAtIndex:1] doubleValue];
	}
    //    NSLog(@"lati: %.10f",latitude);
    //    NSLog(@"long: %.10f",longitude);
    
    
    if([listItems2 count] >= 2) {
		longitude2 = [[listItems2 objectAtIndex:0] doubleValue];
		latitude2 = [[listItems2 objectAtIndex:1] doubleValue];
	}
    //    NSLog(@"lati2: %.10f",latitude2);
    //    NSLog(@"long2: %.10f",longitude2);
    
    
    // Converting double to a string did something funny to the last decimals, limiting the number of decimals helped
    NSMutableString *latstring1 = [NSMutableString stringWithFormat:@"%.10f",latitude];
    NSMutableString *latstring2 = [NSMutableString stringWithFormat:@"%.10f",latitude2];
    NSMutableString *lonstring1 = [NSMutableString stringWithFormat:@"%.10f",longitude];
    NSMutableString *lonstring2 = [NSMutableString stringWithFormat:@"%.10f",longitude2];
    
    //putting together the url for route
    NSString *reitti = [NSString stringWithFormat:@"http://api.reittiopas.fi/hsl/prod/?request=route&from=%@,%@&to=%@,%@&user=neo_ati&pass=vumi_18&detail=full&format=xml&epsg_in=4326&epsg_out=4326&show=1",[lonstring1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[latstring1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[lonstring2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[latstring2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"Reitti: %@",reitti);
    
    //getting the content of the route url
    //    NSString *reittixml = [NSString stringWithContentsOfURL:[NSURL URLWithString:reitti] encoding:NSUTF8StringEncoding error:nil];
    
    
    //    NSLog(@"REITTIOPAS XML: %@",reittixml);
    boolean=NO;
    
    // Get the content of url with route url and parse it with xml parser.
    NSURL *url3 = [[NSURL alloc] initWithString:reitti];
    xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url3];
    [xmlParser setDelegate:self];
    success=[xmlParser parse];
    
    //    NSLog(@"count of the coordinates: %i",[bothCoordsTogether count]);
    
	CLLocationCoordinate2D location;
	location.latitude = latitude;
	location.longitude = longitude;
    doit=location;
	[addressField resignFirstResponder];
    [addressFieldTo resignFirstResponder];
	return location;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    
    //check is the annotation start or end annotation
    if ([(mapAnnotation *)annotation endOrStart]==@"leEnd") {
        
        MKAnnotationView *annWithImg = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"end"];
        annWithImg.canShowCallout = YES;
        annWithImg.calloutOffset = CGPointMake(-5, 1);
        annWithImg.image=[UIImage imageNamed:@"finish1.jpg"];
        
        return annWithImg;
    }
    if ([(mapAnnotation *)annotation endOrStart]==@"leStart") {
        
        MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"start"];
       	annView.pinColor = MKPinAnnotationColorGreen; 
        annView.animatesDrop=YES;
        annView.canShowCallout = YES;
        annView.calloutOffset = CGPointMake(-5, 5);
        
        return annView;
    }
    
    return 0;
}

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
	
}

- (void)viewDidUnload {
    
}




@end
