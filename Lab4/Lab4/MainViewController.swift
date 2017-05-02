//
//  MainViewController.swift
//  Lab4
//
//  Created by Admin on 30.04.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var buttonsStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        changeAxis()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        changeAxis()
    }
    
    func changeAxis() {
        if UIDevice.current.orientation.isLandscape {
            buttonsStackView.axis = UILayoutConstraintAxis.horizontal
        } else {
            buttonsStackView.axis = UILayoutConstraintAxis.vertical
        }
    }
    
    @IBAction func unwindToMainMenu(segue: UIStoryboardSegue){
        
    }
}
