//
//  BaseViewModel.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import RxSwift
import RxRelay

class BaseViewModel {

    // MARK: - Variables
    let disposeBag = DisposeBag()
    let error = PublishRelay<Error>()
    let isLoading = BehaviorRelay(value: false)
    
    // MARK: - Functions
}
