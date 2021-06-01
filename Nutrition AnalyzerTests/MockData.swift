//
//  MockData.swift
//  Nutrition AnalyzerTests
//
//  Created by Mahmoud Eissa on 6/1/21.
//

import Foundation
struct MockData {
    static var success: Data {
        let path = Bundle(for: IngredientsViewModelTests.self).path(forResource: "Success", ofType: "json")!
        return try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
    static var failure: Data {
        let path = Bundle(for: IngredientsViewModelTests.self).path(forResource: "Failure", ofType: "json")!
        return try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
}
