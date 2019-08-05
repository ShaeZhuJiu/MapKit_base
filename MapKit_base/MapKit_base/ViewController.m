//
//  ViewController.m
//  MapKit_base
//
//  Created by 谢鑫 on 2019/8/5.
//  Copyright © 2019 Shae. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
@interface ViewController ()<MKMapViewDelegate>
@property (nonatomic,strong)MKMapView *mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
    //要有复杂的标注，必须要有基本标注
    [self addPoint];
}

- (MKMapView *)mapView{
    if (_mapView==nil) {
        _mapView=[[MKMapView alloc]init];
        //设置mapView的属性
        _mapView.frame=[UIScreen mainScreen].bounds;
        _mapView.mapType=MKMapTypeStandard;
        _mapView.delegate=self;
        _mapView.zoomEnabled=YES;
        _mapView.showsScale=YES;
        _mapView.showsTraffic=YES;
        _mapView.showsCompass=YES;
        //指定地图的中心点经纬度，我们也可以通过CoreLocation框架获取用户当前的坐标
        _mapView.centerCoordinate=CLLocationCoordinate2DMake(32.04, 118.76);
        //地图显示的范围
        MKCoordinateSpan span={0.05,0.05};
        _mapView.region=MKCoordinateRegionMake( _mapView.centerCoordinate, span);
    }
    return _mapView;
}
-(void)addPoint{
    MKPointAnnotation *annotation=[[MKPointAnnotation alloc]init];
    [annotation setCoordinate:self.mapView.centerCoordinate];
    [annotation setTitle:@"侵华日军南京大屠杀遇难同胞纪念馆"];
    [annotation setSubtitle:@"南京市建邺区水西门大街418号"];
    [self.mapView addAnnotation:annotation];
    
}
//代理方法中实现复杂标注
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MKPointAnnotation class]]){
        
        MKAnnotationView *customAnnotationView=(MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
        if (customAnnotationView==nil) {
            customAnnotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
        }
        //设置标注的图片
        customAnnotationView.image=[UIImage imageNamed:@"1"];
        //设置点击标注可以显示更多信息
        customAnnotationView.canShowCallout=YES;
        //右键按钮定制
        UIButton *rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        rightButton.backgroundColor=[UIColor redColor];
        [rightButton setTitle:@"前往" forState:normal];
        customAnnotationView.rightCalloutAccessoryView=rightButton;
        //左键按钮定制
        UIButton *leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        leftButton.backgroundColor=[UIColor blueColor];
        [leftButton setTitle:@"详情" forState:normal];
        customAnnotationView.leftCalloutAccessoryView=leftButton;
        return customAnnotationView;
    }
    return nil;
}
@end
