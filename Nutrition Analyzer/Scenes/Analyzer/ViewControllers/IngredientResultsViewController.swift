//
//  IngredientResultsViewController.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import UIKit

class IngredientResultsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let results: NutritionAnalysisResult
    fileprivate var ingredients: [Ingredient] {
        return results.ingredientResult.flatMap{$0.parsed}
    }
    
    
    // MARK: - Life Cycle
    init(results: NutritionAnalysisResult) {
        self.results = results
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        tableView.registerCell(ofType: IngredientTableViewCell.self)
        title = "Ingredients"
    }
    
    // MARK: - Actions

    @IBAction func totalNutritionClicked(_ sender: UIButton) {
        let controller = NutritionResultsViewController(results: results)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension IngredientResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IngredientTableViewCell = tableView.dequeueReusableCell()!
        cell.populate(ingredients[indexPath.row])
        return cell
    }
}
