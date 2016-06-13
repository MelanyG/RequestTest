//
//  EELocationVC.h
//  
//
//  Created by Melany on 6/13/16.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface EELocationVC : UIViewController <MKMapViewDelegate, MKAnnotation>

@property(strong, nonatomic)NSNumber *longit;
@property(strong, nonatomic)NSNumber *latitud;
@property(strong, nonatomic)NSString *city;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
