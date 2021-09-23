//
//  CardView.swift
//  BoredApp
//
//  Created by Матвей Бойков on 22.09.2021.
//

import Foundation
import UIKit


class CardView : UIView {
    
    @IBOutlet weak var activityTypeLabel: UILabel!
    @IBOutlet weak var activityTypeView: UIView!
    @IBOutlet weak var activityTextView: UITextView!
    
    var viewFromXib : UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        nibSetup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        viewFromXib.frame = bounds
        addSubview(viewFromXib)
        self.layoutIfNeeded()
        testRounding()
    }
    
    func testRounding() {
        self.round(by: 20.0, theseCorners: [.allCorners])
        self.activityTypeView.round(by: 20.0, theseCorners: [.bottomRight])
    }

    
    func nibSetup() {
        viewFromXib = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)![0] as! UIView
    }
}
