//
//  ViewController.swift
//  Lab2
//
//  Created by Admin on 12.04.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit
import Alamofire

class FilmsTableViewController: UITableViewController, UISplitViewControllerDelegate {

    var films = [Film]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.splitViewController?.delegate = self
        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.allVisible
        
        initializeFilmsArray()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! CustomFilmsTableViewCell
        
        cell.filmNameLabel?.text = films[indexPath.row].name
        cell.releaseDateLabel?.text = films[indexPath.row].releaseDate
        cell.ratingLabel?.text = String(films[indexPath.row].rating)
        cell.descriptionLabel?.text = films[indexPath.row].description
        cell.logoImageView?.image = UIImage(named: films[indexPath.row].imageName)
        cell.logoImageView.layer.cornerRadius = 15
        cell.logoImageView.clipsToBounds = true
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filmDetail"{
            
            let destinationNavigationController = segue.destination as! UINavigationController
            
            let destinationController: DetailFilmViewController = destinationNavigationController.viewControllers[0] as! DetailFilmViewController
            //let destinationController: DetailFilmViewController = segue.destination as! DetailFilmViewController
            let indexPath = tableView.indexPathForSelectedRow
            destinationController.film = films[(indexPath?.row)!]
        }
    }
    
    func initializeFilmsArray(){
        let fileName = "films"
        let filePath = Bundle.main.path(forResource: fileName, ofType: "json")
        do {
            let fileData = try! String(contentsOfFile: filePath!, encoding: String.Encoding.utf8)
            let data = fileData.data(using: .utf8)!
            let parsedData = try? JSONSerialization.jsonObject(with: data, options: []) as! NSArray
            for film in parsedData! {
                let arr = film as? NSDictionary
                self.films.append(
                    Film(
                        name: arr!["name"] as! String,
                        releaseDate: arr!["release_date"] as! String,
                        rating: arr!["rating"] as! String,
                        description: arr!["desc"] as! String,
                        imageName: arr!["image"] as! String
                    )
                )
            }
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
