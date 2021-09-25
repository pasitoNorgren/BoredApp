//
//  ViewController.swift
//  BoredApp
//
//  Created by Матвей Бойков on 21.09.2021.
//

import UIKit

class ViewController: UIViewController, Executor {
    
    
    func okay(content: Content?) {
        guard let contentSave = content else { return }
        activityCardView.generalTextLabel.text = contentSave.activity
        activityCardView.activityTypeLabel.text = contentSave.type
    }
    

    @IBOutlet weak var activityCardView: CardView!
    
    let coordinator = Coordinator.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        print("pressed")
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        coordinator.notify(requestType: .randomActivity)
    }
    

    
}

