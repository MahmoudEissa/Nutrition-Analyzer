//
//  IngredientsViewController.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import UIKit
import RxCocoa

class IngredientsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var analizeButton: UIButton!

    // MARK: - Variables
    let viewModel = IngredientsViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "Nutrition Analysis"
    }
    
    override func bindViewsToViewModel() {
        ingredientsTextView.rx.text.orEmpty.asDriver()
            .drive(viewModel.ingredients).disposed(by: disposeBag)
        
        analizeButton.rx.tap.asDriver()
            .drive(onNext: viewModel.analize).disposed(by: disposeBag)
    }
    
    override func bindViewModelToViews() {
        viewModel.isLoading.asDriver()
            .drive(activityIndicatorView.rx.isAnimating).disposed(by: disposeBag)

        viewModel.ingredients.map{ !$0.isEmpty }.asDriver(onErrorJustReturn: false)
            .drive(analizeButton.rx.isEnabled).disposed(by: disposeBag)
        
        viewModel.ingredients.map{ $0.isEmpty ? 0.2 : 1 }.asDriver(onErrorJustReturn: 0.2)
            .drive(analizeButton.rx.alpha).disposed(by: disposeBag)
        
    }
    
    override func setupCallbacks() {
        viewModel.results.subscribe(onNext: { [weak self] results in
            guard let self = self else { return }
            let controller = IngredientResultsViewController(results: results)
            self.navigationController?.pushViewController(controller, animated: true)
            
        }).disposed(by: disposeBag)
        
        viewModel.error.subscribe(onNext: { [weak self] error in
            guard let self = self else { return }
            self.showAlert(title: "Error", message: error.localizedDescription)
        }).disposed(by: disposeBag)    }
    
    // MARK: - Actions
}
