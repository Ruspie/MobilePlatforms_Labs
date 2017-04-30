//
//  MapViewController.swift
//  Lab3
//
//  Created by Admin on 25.04.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate{

    var weather = Weather()
    
    private var camera: GMSCameraPosition = GMSCameraPosition()
    private var mapView: GMSMapView = GMSMapView()
    private var marker: GMSMarker = GMSMarker()
    
    private let startCoordinate = CLLocationCoordinate2D(latitude: 53.911850, longitude: 27.594933) // Coordinates of Minsk
    
    override func viewDidLoad() {
        super.viewDidLoad()

        camera = GMSCameraPosition.camera(withTarget: startCoordinate, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        mapView.settings.rotateGestures = false
        
        view = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - MapView Delegate (Tap at coorinate)
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let request = "http://api.openweathermap.org/data/2.5/weather?lat=" + String(coordinate.latitude) + "&lon=" + String(coordinate.longitude) + "&APPID=e514485a6c0cc7dff90d0e02f1a31798"
        Alamofire.request(request).responseJSON{
            response in
            
            if response.result.value != nil {
                print(response)
                let info = response.result.value as! NSDictionary
                let sity = info["name"] as! String
                let temperature = (info["main"] as! NSDictionary)["temp"] as! Double - 273.0
                let wind = (info["wind"] as! NSDictionary)["speed"] as! Double
                let description = ((info["weather"] as! NSArray)[0] as! NSDictionary)["description"] as! String
                let longitude = (info["coord"] as! NSDictionary)["lon"] as! Double
                let latitude = (info["coord"] as! NSDictionary)["lat"] as! Double
                    
                self.weather = Weather(sity: sity, temperature: temperature, wind: wind, description: description, longitude: longitude, latitude: latitude)
             
                self.camera = GMSCameraPosition.camera(withLatitude: self.weather.latitude, longitude: self.weather.longitude, zoom: 10.0)
                self.mapView.camera = self.camera
                
                self.marker.position = CLLocationCoordinate2DMake(self.weather.latitude, self.weather.longitude)
                self.marker.title = self.weather.sity
                self.marker.snippet = self.weather.getSnippedInfo()
                self.marker.map = mapView
            }
            else{
                self.showAlert(message: "Cannot connect to weather service, please, try it again!")
            }
        }
    }
    
    func showAlert(message : String){
        let alert = UIAlertController(title: "Warning!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
        show(alert, sender: self)
    }
}
