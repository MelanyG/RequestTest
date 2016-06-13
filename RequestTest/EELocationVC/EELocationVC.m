//
//  EELocationVC.m
//
//
//  Created by Melany on 6/13/16.
//
//

#import "EELocationVC.h"
#import "EEImageVC.h"

@interface EELocationVC ()

-(void)updateMapViewAnnotation;

@end

@implementation EELocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.city;
    self.mapView.delegate = self;
    [self.mapView setShowsUserLocation:YES];
    [self updateMapViewAnnotation];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self.latitud doubleValue];
    coordinate.longitude = [self.longit doubleValue];
    
    return coordinate;
}

-(void)updateMapViewAnnotation {
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([self.latitud doubleValue], [self.longit doubleValue]);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(10.9, 10.9);
    MKCoordinateRegion region = {coord, span};
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coord];
    
    [self.mapView setRegion:region];
    [annotation setTitle:self.city];

    [self.mapView addAnnotation:annotation];

}
#pragma mark - MKMapView Delegates

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
static NSString *reuseID = @"EELocationVC";
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseID];
    if(!view) {
        view = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:reuseID];
        view.canShowCallout = YES;
        UIImageView *lImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 46, 46)];
        view.leftCalloutAccessoryView = lImageView;
        UIButton *disclusureButton = [[UIButton alloc]init];
        [disclusureButton setBackgroundImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [disclusureButton sizeToFit];
        view.rightCalloutAccessoryView = disclusureButton;
    }
    view.annotation = annotation;
    [self updateLeftCalloutAccessoryViewInAvvotationView:view];
    return view;
}



-(void)updateLeftCalloutAccessoryViewInAvvotationView:(MKAnnotationView *)annotationView {
    UIImageView *imageView = nil;
    if([annotationView.leftCalloutAccessoryView isKindOfClass:[UIImageView class]]) {
        imageView = (UIImageView *)annotationView.leftCalloutAccessoryView;
    }
    imageView.image = [UIImage imageNamed:@"star"];
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {

    [self performSegueWithIdentifier:@"image" sender:view];
}

-(void)prepareViewController:(id)vc forSegue:(NSString *)segueIdentifier toShowAnnotation:(id <MKAnnotation>)annotation {
    if( [segueIdentifier isEqualToString:@"image"]) {
        if([vc isKindOfClass:[EEImageVC class]]) {
            EEImageVC *lVc = (EEImageVC *)vc;
            lVc.image = [UIImage imageNamed:@"beach"];
        }
    }
}



 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([sender isKindOfClass:[MKAnnotationView class]]) {
         [self prepareViewController:segue.destinationViewController forSegue:segue.identifier toShowAnnotation:((MKAnnotationView *)sender).annotation];
     }
 }


@end
