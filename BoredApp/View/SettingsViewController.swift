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
    @IBOutlet weak var priceSwitch: UISwitch!
    @IBOutlet weak var stepperOutlet: UIStepper!
    var priceSwitchValue : Bool = true
    var currentlyChosenButton : UIButton?
    
    var currentFilterSettings : FilteredContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        implementCurrentlyChosenFilterParamaters()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonsCornersRounding()
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
}

extension SettingsViewController {
    
    func implementCurrentlyChosenFilterParamaters() {
        guard let safeSettings = currentFilterSettings else { return }
        priceSwitch.setOn(safeSettings.price, animated: false)
        priceSwitchValue = safeSettings.price
        if let safeParticipantsLabel = safeSettings.participants {
            participantsCountLabel.text = safeParticipantsLabel
            guard let safeValueForStepper = Double(safeParticipantsLabel) else { return }
            stepperOutlet.value = safeValueForStepper
            
        } else {
            participantsCountLabel.text = K.SettingsVC.participantsCountLabelForRandom
            stepperOutlet.value = 0
        }
        findButtonToChoose(with: safeSettings.type)
    }
    
    func findButtonToChoose(with title : String) {
        let normalButtonTitleText = Interpreter.getCardViewTypeName(type: title)
        for btn in typeButtons {
            if normalButtonTitleText == btn.titleLabel?.text {
                currentlyChosenButton = btn
                break
            }
        }
        guard let safeCurrentlyChosenButton = currentlyChosenButton else { return }
        currentlyChosenButtonSetup(safeCurrentlyChosenButton, fromViewDidLoad: true)
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
        let buttonType = Interpreter.representation(OfActivityType: buttonTitleText)
        let result = Interpreter.requestShaper(buttonActivityType: buttonType,
                                               participantsTitle: participNumber,
                                               priceIsEnabled: priceSwitchValue)
        
        Coordinator.shared.notify(requestType: result.requestType,
                                  filteredModel: result.model)
    }
    
    func switchValueSetting(_ sender : UISwitch) {
        priceSwitchValue = sender.isOn
    }
    
    func participantsCount( _ sender : UIStepper) {
        if sender.value == 0 {
            participantsCountLabel.text = K.SettingsVC.participantsCountLabelForRandom
        } else {
            participantsCountLabel.text = String(Int(sender.value))
        }
    }
    
    func currentlyChosenButtonSetup(_ sender : UIButton, fromViewDidLoad index : Bool = false) {
        if !index {
            currentlyChosenButton = ((currentlyChosenButton == nil) || (currentlyChosenButton != sender)) ? sender : nil
        }
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
            buttonTitle = K.SettingsVC.dismissButtonSuccess
            applyCnangesButton.backgroundColor = UIColor.systemGreen
        } else {
            buttonTitle = K.SettingsVC.dismissButtonFail
            applyCnangesButton.backgroundColor = UIColor.systemRed
        }
        applyCnangesButton.setTitle(buttonTitle, for: .normal)
    }
    
}
