//
//  NutritionResultsViewController.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import UIKit

class NutritionResultsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    // MARK: - Variables
    let results: NutritionAnalysisResult
    fileprivate lazy var nutritionsFats: [NutrientInfo] = loadInfo()
    
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
        tableView.registerCell(ofType: NutritionFactTableViewCell.self)
        caloriesLabel.text = results.calories.string(style: .none)
        title = "Nutrition Facts"
    }
    
    func loadInfo() -> [NutrientInfo] {
        return results.totalDaily.compactMap({$0.value})
    }
    // MARK: - Actions

}
extension NutritionResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nutritionsFats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NutritionFactTableViewCell = tableView.dequeueReusableCell()!
        cell.populate(nutritionsFats[indexPath.row])
        return cell
    }
}
