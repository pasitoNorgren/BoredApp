//
//  ViewController.swift
//  BoredApp
//
//  Created by Матвей Бойков on 21.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var filterSettings : FilteredContent?
    
    @IBOutlet weak var arrowImageView: UIImageView!
    
    @IBOutlet weak var activityCardView: CardView?
    
    let coordinator = Coordinator.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateButtonBehaviour()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print("pressed")
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        updateButtonBehaviour()
        animateArrowImageView()
    }
    
    func updateButtonBehaviour() {
        if let _ = filterSettings {
            coordinator.notify(requestType: .filteredActivity, filteredModel: filterSettings)
        } else {
            coordinator.notify(requestType: .randomActivity)
        }
    }
    
    func animateArrowImageView(startPoint : CGFloat = 1, endPoint : CGFloat = 0.5, duration : TimeInterval = 0.1) {
        arrowImageView.alpha = startPoint
        UIView.animate(withDuration: duration) {
            self.arrowImageView.alpha = endPoint
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
}

extension ViewController : Executor {
    
    func performsAction(content: Content?, errorDescription : AlertInfo?) {
        animateArrowImageView(startPoint: arrowImageView.alpha, endPoint: 1, duration: 0.1)
        if let safeContent = content {
            activityCardUpdateWithAnimation(with: safeContent)
        } else {
            guard let description = errorDescription else { return }
        }
       
    }
    
    func filterSettingsSetup(with model: FilteredContent?) {
        filterSettings = model
    }
}

