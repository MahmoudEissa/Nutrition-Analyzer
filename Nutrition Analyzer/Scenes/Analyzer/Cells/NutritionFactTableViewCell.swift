//
//  NutritionFactTableViewCell.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import UIKit

class NutritionFactTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func populate(_ info: NutrientInfo) {
        titleLabel.text = info.title
        valueLabel.text = info.quantity.string(style: .none) + " \(info.unit)"
    }
    
}
