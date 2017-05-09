//
//  WeatherTableViewController.swift
//  Lab2
//
//  Created by Admin on 19.04.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit
import Alamofire

class WeatherTableViewController: UITableViewController {
    
    var weathers = [Weather]()
    var refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher.addTarget(self, action: #selector(self.refreshing), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refresher)
        initializeWeatherArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }

    func refreshing(){
        weathers.removeAll()
        
        initializeWeatherArray()
        refresher.endRefreshing()
    }
    
    func initializeWeatherArray(){
        Alamofire.request("http://api.openweathermap.org/data/2.5/box/city?bbox=12,32,15,37,10&APPID=e514485a6c0cc7dff90d0e02f1a31798").responseJSON{ responce in

            if responce.result.value != nil {
                print(responce)
                let json = responce.result.value as! NSDictionary
                let array = json["list"] as! NSArray
                for data in array {
                    let info = data as! NSDictionary
                    let sity = info["name"] as! String
                    let wind = (info["wind"] as! NSDictionary)["speed"] as! Double
                    let weather = ((info["weather"] as! NSArray)[0] as! NSDictionary)["description"] as! String
                    let temperature = (info["main"] as! NSDictionary)["temp"] as! Double
                    
                    self.weathers.append(Weather(sity: sity, temperature: temperature, wind: String(wind), main: weather))
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! CustomWeatherTableViewCell
        if (weathers.count != 0) {
            cell.sityLabel.text = weathers[indexPath.row].sity
            cell.temperatureLabel.text = String(weathers[indexPath.row].temperature) + "°C"
            cell.weatherLabel.text = weathers[indexPath.row].main
            cell.windLabel.text = weathers[indexPath.row].wind + "m/s"
            cell.changeAxis()
        }
        
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.reloadData()
    }
}
