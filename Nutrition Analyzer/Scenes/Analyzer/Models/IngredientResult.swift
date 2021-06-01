//
//  IngredientResult.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import ObjectMapper

class IngredientResult: BaseModel {
    
    var text = ""
    var parsed: [Ingredient] = []
    override func mapping(map: Map) {
        super.mapping(map: map)
        text <- map["text"]
        parsed <- map["parsed"]
    }
    
}
