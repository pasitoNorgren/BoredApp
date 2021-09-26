//
//  ViewController.swift
//  BoredApp
//
//  Created by Матвей Бойков on 21.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var filterSettings : FilteredContent?
    
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
        updateButtonBehaviour()
    }
    
    func updateButtonBehaviour() {
        print(filterSettings == nil)
        if let _ = filterSettings {
            coordinator.notify(requestType: .filteredActivity, filteredModel: filterSettings)
        } else {
            coordinator.notify(requestType: .randomActivity)
        }
    }
}

extension ViewController : Executor {
    
    func okay(content: Content?, errorString : String?) {
//        guard let contentSave = content else { return }
        if let safeContent = content {
            activityCardView.generalTextLabel.text = safeContent.activity
            activityCardView.activityTypeLabel.text = safeContent.type
        } else {
            print(errorString)
        }
       
    }
    
    func filterSettingsSetup(with model: FilteredContent?) {
        filterSettings = model
    }
}

