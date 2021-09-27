//
//  CardView.swift
//  BoredApp
//
//  Created by Матвей Бойков on 22.09.2021.
//

import Foundation
import UIKit


class CardView : UIView {
    
    @IBOutlet weak var activityTypeLabel: UILabel?
    @IBOutlet weak var activityTypeView: UIView?
    @IBOutlet weak var generalTextLabel: UILabel?
    @IBOutlet weak var favorImageView: UIImageView?
    @IBOutlet weak var participantsLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    
    var viewFromXib : UIView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        nibSetup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let safeViewFromXib = viewFromXib else { return }
        safeViewFromXib.frame = bounds
        addSubview(safeViewFromXib)
        self.layoutIfNeeded()
        apperanceSetup()
    }
    
    func apperanceSetup() {
        self.round(by: 20.0, theseCorners: [.allCorners])
        self.activityTypeView?.round(by: 20.0, theseCorners: [.bottomRight])
        generalTextLabel?.adjustsFontSizeToFitWidth = true
        generalTextLabel?.minimumScaleFactor = 0.2
        favorImageView?.isHidden = true
    }
    
    func nibSetup() {
        viewFromXib = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?[0] as? UIView
    }
}
