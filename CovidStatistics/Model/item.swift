//
//  item.swift
//  CovidStatistics
//
//  Created by l.vladislava on 14/02/2021.
//

import Foundation
import Gloss


struct Item: JSONDecodable {
    
//    var description: String
    var country: String
    var cases: AnyClass?
//    var url: String
    
    init?(json: JSON){
        self.country = "country"  <~~ json ?? ""
        self.cases = "cases" <~~ json //        self.description = "description" <~~ json ?? ""
//        self.url = "url" <~~ json ?? ""
    }
}

