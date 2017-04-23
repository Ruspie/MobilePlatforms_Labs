//
//  ViewController.swift
//  Lab2
//
//  Created by Admin on 12.04.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit
import Alamofire

class FilmsTableViewController: UITableViewController{

    var films = [Film]()
        /*[Film(name: "test", releaseDate: "03.11.2014", rating: 3.14, description: "test testtesttesttest testtest testtest testtesttesttest testtesttesttesttesttest testtest testtesttesttest testtest testtest testtesttesttesttesttest testtest testtest testtest", imageName: "test")]*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeFilmsArray()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
            let destinationController: DetailViewController = segue.destination as! DetailViewController
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
}
