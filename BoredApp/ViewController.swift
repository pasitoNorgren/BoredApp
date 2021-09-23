//
//  ViewController.swift
//  BoredApp
//
//  Created by Матвей Бойков on 21.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activityCardView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        print("pressed")
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        print("update button pressed")
    }
}

