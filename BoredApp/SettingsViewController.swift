//
//  SettingsViewController.swift
//  BoredApp
//
//  Created by Матвей Бойков on 23.09.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var typeButtons: [UIButton]!
    @IBOutlet weak var participantsCountLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    var priceSwitchValue : Bool = true
    var currentlyChosenButton : UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        currentlyChosenButton = typeButtons[0]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundingSetup()
    }
        
    @IBAction func dismissing(_ sender: UIButton) {
        if let chosenButton = currentlyChosenButton {
            print(chosenButton.titleLabel?.text)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func priceSwitchChanged(_ sender: UISwitch) {
        priceSwitchValue = sender.isOn
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        participantsCountLabel.text = String(Int(sender.value))
    }
    
    @IBAction func typeButtonPressed(_ sender: UIButton) {
        print(currentlyChosenButton?.titleLabel?.text)
        if (currentlyChosenButton == nil) || (currentlyChosenButton != sender)  {
            currentlyChosenButton = sender
            dismissButton.titleLabel?.text = "Apply changes"
            sender.layer.borderColor = UIColor.yellow.cgColor
            sender.layer.borderWidth = 2
        } else {
            currentlyChosenButton!.layer.borderColor = .none
            currentlyChosenButton!.layer.borderWidth = 0
            currentlyChosenButton = nil
            dismissButton.titleLabel?.text = "Dismiss the window"
            
        }
        print(currentlyChosenButton?.titleLabel?.text)
        
//        guard let activityType = sender.titleLabel?.text else { return }
        
        
    }
    
    func roundingSetup() {
        for button in typeButtons {
            button.layoutIfNeeded()
            button.round(by: 20.0, theseCorners: [.topLeft,.bottomRight])
        }
        dismissButton.round(by: 20, theseCorners: [.allCorners])
    }
    
    deinit {
        print("deinited")
    }
    
}
