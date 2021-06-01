//
//  IngredientTableViewCell.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var foodMatchLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!

    // MARK: - Variables
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func populate(_ ingredient: Ingredient) {
        foodMatchLabel.text = ingredient.foodMatch
        foodLabel.text = ingredient.food
        unitLabel.text = ingredient.measure
        caloriesLabel.text = ingredient.calories.string(style: .none)
        quantityLabel.text = String(ingredient.quantity)
        weightLabel.text = ingredient.weight.string(style: .none)
    }

}
