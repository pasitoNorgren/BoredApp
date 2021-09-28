//
//  ViewController.swift
//  BoredApp
//
//  Created by Матвей Бойков on 21.09.2021.
//

import UIKit
import CDAlertView

class ViewController: UIViewController {
    
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var activityCardView: CardView?
    
    let coordinator = Coordinator.shared
    
    var filterSettings : FilteredContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateButtonBehaviour()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.VCtoSVCsegueIdentifier, sender: self)
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        updateButtonBehaviour()
        animateArrowImageView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.VCtoSVCsegueIdentifier {
            if let vc = segue.destination as? SettingsViewController {
                vc.currentFilterSettings = filterSettings
            }
        }
    }
    
}

extension ViewController : Executor {
    
    func performsAction(content: Content?, errorDescription : AlertInfo?) {
        if let safeContent = content {
            activityCardUpdateWithAnimation(with: safeContent)
        } else {
            guard let description = errorDescription else { return }
            alertSetup(with: description)
        }
    }
    
    func filterSettingsSetup(with model: FilteredContent?) {
        filterSettings = model
    }
}

extension ViewController {
    
    func updateButtonBehaviour() {
        if let _ = filterSettings {
            coordinator.notify(requestType: .filteredActivity, filteredModel: filterSettings)
        } else {
            coordinator.notify(requestType: .randomActivity)
        }
    }
    
    func animateArrowImageView(duration : TimeInterval = 0.1) {
        let angle : CGFloat = .random(in: -360...360)
        UIView.animate(withDuration: duration) {
            self.arrowImageView.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    func activityCardUpdateWithAnimation(with model : Content) {
        guard let safeActivityCardView = activityCardView else { return }
        guard let safeGeneralTextLabel = safeActivityCardView.generalTextLabel else { return }
        guard let safeActivityTypeLabel = safeActivityCardView.activityTypeLabel else { return }
        guard let safeParticipantsLabel = safeActivityCardView.participantsLabel else { return }
        guard let safePriceLabel = safeActivityCardView.priceLabel else { return }
        
        safeGeneralTextLabel.alpha = 0
        
        safeGeneralTextLabel.text = model.activity
        safeActivityTypeLabel.text = Interpreter.getCardViewTypeName(type : model.type)
        safeActivityTypeLabel.backgroundColor = Colourist.giveMeColour(type: model.type)
        safeParticipantsLabel.text = String(model.participants)
        safePriceLabel.text = String(model.price)
        
        UIView.animate(withDuration: 0.15) { safeGeneralTextLabel.alpha = 1 }
    }
    
    func alertSetup(with info : AlertInfo) {
        let alertTitle = K.mainAlertTitle
        let alertMessage = info.errorDescriprion
        let buttonTitle = info.errorType.rawValue
        let alertType : CDAlertViewType = info.errorType == .parsing ? .warning : .error
 
        let alert = CDAlertView(title: alertTitle, message: alertMessage, type: alertType)
        alert.alertBackgroundColor = UIColor(named: K.mainBackgroundColourName) ?? UIColor.white
        alert.titleTextColor = UIColor(named: K.sliderTintColourName) ?? UIColor.black
        alert.messageTextColor = UIColor(named: K.sliderTintColourName) ?? UIColor.black
        
        var alertAction = CDAlertViewAction()
        if info.errorType == .parsing {
            alertAction = CDAlertViewAction(title: buttonTitle, font: UIFont.boldSystemFont(ofSize: 17), textColor: UIColor(named: K.sliderTintColourName), backgroundColor: alert.alertBackgroundColor) { [weak self] (action) -> Bool in
                self?.performSegue(withIdentifier: K.VCtoSVCsegueIdentifier, sender: self)
                return true
            }
            
            let defaultAction = CDAlertViewAction(title: "Close")
            defaultAction.buttonTextColor = UIColor(named: K.sliderTintColourName)
            alert.add(action: defaultAction)
            
        } else {
            alertAction = CDAlertViewAction(title: buttonTitle)
        }
        alertAction.buttonTextColor = UIColor(named: K.sliderTintColourName)
        alert.add(action: alertAction)
        alert.show()
    }
    
}

