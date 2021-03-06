//
//  ViewController.m
//  MobileMapper
//
//  Created by Ronald Hernandez on 3/24/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property MKPointAnnotation *mobileMakersAnnotation;
@property CLLocationManager *locationManager;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //--Allows to display user's location--//
    self.locationManager = [[CLLocationManager alloc]init];

    [self.locationManager requestWhenInUseAuthorization];

    self.mapView.showsUserLocation = true;
    
    //Display
    double latitude = 37.790752;
    double longitude = -122.402039;
    CLLocationCoordinate2D makersCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    self.mobileMakersAnnotation = [[MKPointAnnotation alloc] init];
    self.mobileMakersAnnotation.title = @"Mobile Makers";
    self.mobileMakersAnnotation.coordinate = makersCoordinate;
    [self.mapView addAnnotation:self.mobileMakersAnnotation];

    [self addAnnotationForAddress:@"Mount Rushmore"];



}


#pragma mark MapKit Delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *pinAnnotation = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    if ([annotation isEqual:self.mobileMakersAnnotation]) {
        pinAnnotation.image = [UIImage imageNamed:@"mobilemakers"];
    }else if([annotation isEqual:mapView.userLocation]){


        return nil;
    }

    pinAnnotation.canShowCallout = true;
    pinAnnotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    return pinAnnotation;
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    CLLocationCoordinate2D center = view.annotation.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    [mapView setRegion:MKCoordinateRegionMake(center, span) animated:true];
}

-(void)addAnnotationForAddress:(NSString *)address{

    CLGeocoder *geocoder = [[CLGeocoder alloc]init];

    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"%@",error.localizedDescription);

        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        MKPointAnnotation *pin = [[MKPointAnnotation alloc]init];
        pin.coordinate = placemark.location.coordinate;
        pin.title = placemark.name;
        [self.mapView addAnnotation:pin];
    }];

}


@end
