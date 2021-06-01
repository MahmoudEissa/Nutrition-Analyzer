//
//  NutrientInfo.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import ObjectMapper

class NutrientInfo: BaseModel {
    
    var title: String = ""
    var unit: String = ""
    var quantity: Float = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        title <- map["label"]
        unit <- map["unit"]
        quantity <- map["quantity"]
    }
}
