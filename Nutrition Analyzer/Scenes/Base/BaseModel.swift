//
//  BaseModel.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import ObjectMapper

public class BaseModel: Mappable {
    public required init?(map: Map) { }
    public func mapping(map: Map) {}
}
