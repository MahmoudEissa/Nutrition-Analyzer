//
//  IngredientsViewModelTests.swift
//  Nutrition AnalyzerTests
//
//  Created by Mahmoud Eissa on 5/31/21.
//

import XCTest
import RxSwift
import RxTest
@testable import Nutrition_Analyzer

class IngredientsViewModelTests: XCTestCase {

    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    var sut: IngredientsViewModel!
    
    override func setUp() {
        super.setUp()
        disposeBag = .init()
        scheduler = .init(initialClock: 0)
        sut = .init()
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockURLProtocol.self]
        NetworkManager.session = .init(configuration: configuration)
    }
    
    override  func tearDown() {
        disposeBag = nil
        scheduler = nil
        sut = nil
        super.tearDown()
    }

    func testIngredientsViewModel_whenEnterValidData_willFetchCalories() {
        sut.ingredients.accept("1 Apple")
        MockURLProtocol.responseWithStatusCode(code: 200, data: MockData.success)
        sut.analize()
        let expectation = expectation(description: "Getting valid values")
        sut.results.subscribe(onNext: { result in
            XCTAssertGreaterThan(result.calories, 0)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        waitForExpectations(timeout: 10)
    }
    
    func testIngredientsViewModel_whenEnterInValidData_willFail() {
        sut.ingredients.accept(".......")
        MockURLProtocol.responseWithStatusCode(code: 200, data: MockData.failure)
        sut.analize()
        let expectation = expectation(description: "Getting valid values")

        sut.error.subscribe(onNext: { error in
            XCTAssertEqual(error.localizedDescription, "We cannot calculate the nutrition for some ingredients. Please check the ingredient spelling or if you have entered a quantities for the ingredients.")
            expectation.fulfill()
        }).disposed(by: disposeBag)
        waitForExpectations(timeout: 10)
    }
    
    func testIngredientsViewModel_whenFetchData_isLoading() {
        let results = scheduler.createObserver(Bool.self)
        sut.isLoading.asDriver().skip(1)
            .drive(results).disposed(by: disposeBag)
        sut.ingredients.accept("1 Apple")
        MockURLProtocol.responseWithStatusCode(code: 200, data: MockData.success)
        sut.analize()
        let expectation = expectation(description: "Getting valid values")
        sut.results.subscribe{ _ in
            expectation.fulfill()
        }.disposed(by: disposeBag)
        waitForExpectations(timeout: 10)
        XCTAssertRecordedElements(results.events, [true, false])
    }
    
    func testIngredientsViewModel_whenFailToFetchingData_isLoading() {
        let results = scheduler.createObserver(Bool.self)
        sut.isLoading.asDriver().skip(1)
            .drive(results).disposed(by: disposeBag)
        sut.ingredients.accept(".......")
        MockURLProtocol.responseWithStatusCode(code: 200, data: MockData.failure)
        sut.analize()
        let expectation = expectation(description: "Getting invalid values")
        sut.error.subscribe{ _ in
            expectation.fulfill()
        }.disposed(by: disposeBag)
        waitForExpectations(timeout: 10)
        XCTAssertRecordedElements(results.events, [true, false])
    }

}
