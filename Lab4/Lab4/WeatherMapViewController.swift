//
//  WeatherMapViewController.swift
//  Lab3
//
//  Created by Admin on 24.04.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit
import GoogleMaps

class WeatherMapViewController: UIViewController{

    var weather: WeatherV2 = WeatherV2()
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        searchController?.isActive = false
        
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: weather.latitude, longitude: weather.longitude, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.setAllGesturesEnabled(false)
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: weather.latitude, longitude: weather.longitude)
        marker.title = weather.sity
        marker.snippet = weather.getSnippedInfo()
        marker.map = mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
