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
    @IBOutlet weak var applyCnangesButton: UIButton!
    var priceSwitchValue : Bool = true
    var currentlyChosenButton : UIButton?
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonsCornersRounding()
    }
    
    deinit {
        print("deinited")
    }
    
    @IBAction func applyChangesPressed(_ sender: UIButton) {
        applyChangesButtonBehaviour(currentlyChosenButton)
    }
    
    @IBAction func priceSwitchChanged(_ sender: UISwitch) {
        switchValueSetting(sender)
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
       participantsCount(sender)
    }
    
    @IBAction func typeButtonPressed(_ sender: UIButton) {
        currentlyChosenButtonSetup(sender)
    }
    
    func buttonsCornersRounding() {
        
        for button in typeButtons {
            button.layoutIfNeeded()
            button.round(by: 20.0, theseCorners: [.topLeft,.bottomRight])
        }
        applyCnangesButton.round(by: 20, theseCorners: [.allCorners])
    }
    
    func applyChangesButtonBehaviour(_ sender : UIButton?) {
        dismiss(animated: true, completion: nil)
        guard let chosenButton = sender else { return }
        guard let buttonTitleText = chosenButton.titleLabel?.text else { return }
        guard let participNumber = participantsCountLabel.text else { return }
        let typeRawValue = Interpreter.representation(OfActivityType: buttonTitleText).rawValue
        
        Coordinator.shared.notify(requestType: .filteredActivity,
                                  filteredModel: FilteredContent(type: typeRawValue,
                                                                 participants: participNumber,
                                                                 price: priceSwitchValue))
        
    }
    
    func switchValueSetting(_ sender : UISwitch) {
        priceSwitchValue = sender.isOn
    }
    
    func participantsCount( _ sender : UIStepper) {
        participantsCountLabel.text = String(Int(sender.value))
    }
    
    func currentlyChosenButtonSetup(_ sender : UIButton) {
        currentlyChosenButton = ((currentlyChosenButton == nil) || (currentlyChosenButton != sender)) ? sender : nil
        transparencyControl(for: currentlyChosenButton)
        applyChangesButtonTitle(according: currentlyChosenButton)
    }
    
    func transparencyControl(for button : UIButton?) {
        if let notOptionalchosenTypeButton = button {
            for btn in typeButtons {
                if btn != notOptionalchosenTypeButton {
                    btn.alpha = 0.5
                } else {
                    btn.alpha = 1 }
            }
        } else {
            for btn in typeButtons {
                btn.alpha = 1
            }
        }
    }

    func applyChangesButtonTitle(according button : UIButton?) {
        var buttonTitle = String()
        if let _ = button {
            buttonTitle = "Apply changes"
        } else {
            buttonTitle = "Dismiss the window"
        }
        applyCnangesButton.setTitle(buttonTitle, for: .normal)
    }
    
}
