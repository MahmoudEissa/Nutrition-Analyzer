//
//  IngredientsViewModel.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import RxSwift
import RxRelay

class IngredientsViewModel: BaseViewModel {
    
    // MARK: - Variables
    let ingredients: BehaviorRelay<String> = .init(value: "")
    let results: PublishRelay<NutritionAnalysisResult> = .init()
    
    // MARK: - Functions
    public func analize() {
        isLoading.accept(true)
        analize(ingredients: ingredients.value.components(separatedBy: "\n"))
            .subscribe { [weak self] results in
                guard let self = self else { return }
                self.isLoading.accept(false)
                guard results.calories > 0 else {
                    return self.error.accept(NSError.init(error: "We cannot calculate the nutrition for some ingredients. Please check the ingredient spelling or if you have entered a quantities for the ingredients.", code: -1))
                }
                self.results.accept(results)
            } onError: {[weak self] error in
                guard let self = self else { return }
                self.isLoading.accept(false)
                self.error.accept(error)
                
            }.disposed(by: disposeBag)
    }
    
     func analize(ingredients: [String]) -> Single<NutritionAnalysisResult> {
        return AnalyzerAPI.analize(ingredients: ingredients)
    }
}
