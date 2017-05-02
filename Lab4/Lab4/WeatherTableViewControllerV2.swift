//
//  WeatherTableViewController.swift
//  Lab3
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit
import Alamofire

class WeatherTableViewControllerV2: UITableViewController, UISearchResultsUpdating, UISplitViewControllerDelegate {

    private var weathers = [WeatherV2]()
    private var searchResultWeather = [WeatherV2]()
    private var refresher = UIRefreshControl()
    private var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        refresher.attributedTitle = NSAttributedString(string: "Updating...")
        refresher.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refresher)
        
        self.splitViewController?.delegate = self
        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.allVisible
        
        initializeWeathers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - TableView
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchResultWeather.count : weathers.count
    }

    func refresh(){
        weathers.removeAll()
        
        initializeWeathers()
        refresher.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! CustomWeatherTableViewCellV2
        
        if (weathers.count != 0) {
            
            let weather = searchController.isActive ? searchResultWeather[indexPath.row] : weathers[indexPath.row]
            cell.sityLabel.text = weather.sity
            cell.temperatureLabel.text = String(weather.temperature) + "°C"
        }
        
        return cell
    }
    
    //MARK: - Work with model
    
    func initializeWeathers(){
        Alamofire.request("http://api.openweathermap.org/data/2.5/box/city?bbox=23.043985,51.542330,32.686218,56.140902,10&APPID=e514485a6c0cc7dff90d0e02f1a31798").responseJSON {
            response in
            
            if response.result.value != nil {
                print(response)
                let json = response.result.value as! NSDictionary
                let array = json["list"] as! NSArray
                for data in array {
                    let info = data as! NSDictionary
                    let sity = info["name"] as! String
                    let temperature = (info["main"] as! NSDictionary)["temp"] as! Double
                    let wind = (info["wind"] as! NSDictionary)["speed"] as! Double
                    let description = ((info["weather"] as! NSArray)[0] as! NSDictionary)["description"] as! String
                    let longitude = (info["coord"] as! NSDictionary)["Lon"] as! Double
                    let latitude = (info["coord"] as! NSDictionary)["Lat"] as! Double
                    
                    self.weathers.append(WeatherV2(sity: sity, temperature: temperature, wind: wind, description: description, longitude: longitude, latitude: latitude))
                }
                self.tableView.reloadData()
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
    
    // MARK: - SearchController
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(searchText: searchText)
            tableView.reloadData()
        }
    }
    
    func filterContent(searchText: String){
        searchResultWeather = weathers.filter({ (weather: WeatherV2) -> Bool in
            
            if (searchText == "") {
                return true
            }
            
            let nameMatch = weather.sity.range(of: searchText as String, options: String.CompareOptions.caseInsensitive)
            let temperatureMatch = String(weather.temperature).range(of: searchText, options: String.CompareOptions.caseInsensitive)
            
            return nameMatch != nil || temperatureMatch != nil
        })
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherDetail"{
            //let destinationController : WeatherMapViewController = segue.destination as! WeatherMapViewController
            
            let destinationNavigationController: UINavigationController = segue.destination as! UINavigationController
            
            let destinationController: WeatherMapViewController = destinationNavigationController.viewControllers[0] as! WeatherMapViewController
            
            let indexPath = tableView.indexPathForSelectedRow
            
            destinationController.weather = searchController.isActive ? searchResultWeather[(indexPath?.row)!]  : weathers[(indexPath?.row)!]
            destinationController.searchController = self.searchController
        }
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}
