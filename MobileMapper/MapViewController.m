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


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *pinAnnotation = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    pinAnnotation.image = [UIImage imageNamed:@"mobilemakers"];
    pinAnnotation.canShowCallout = true;
    pinAnnotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    return pinAnnotation;

}

#pragma mark MapKit Delegate
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
