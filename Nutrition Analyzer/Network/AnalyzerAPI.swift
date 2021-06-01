//
//  API.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import ESNetworkManager
import RxSwift
import Alamofire

public class AnalyzerAPI {
    class func analize(ingredients: [String]) -> Single<NutritionAnalysisResult> {
        let request = ESNetworkRequest("nutrition-details")
        request.encoding = JSONEncoding.default
        request.parameters = [ "ingr": ingredients]
        request.method = .post
        return NetworkManager.execute(request: request)
    }
}
