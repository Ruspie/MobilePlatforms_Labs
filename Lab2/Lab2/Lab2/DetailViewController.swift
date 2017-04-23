//
//  DetailViewController.swift
//  Lab2
//
//  Created by Admin on 19.04.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var filmsLogoImageView: UIImageView!
    @IBOutlet weak var filmsNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var film = Film()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        filmsLogoImageView.image = UIImage(named: film.imageName)
        filmsLogoImageView.layer.cornerRadius = 15
        filmsLogoImageView.clipsToBounds = true
        filmsNameLabel.text = film.name
        releaseDateLabel.text = film.releaseDate
        ratingLabel.text = film.rating
        descriptionLabel.text = film.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
