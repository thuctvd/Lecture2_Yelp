//
//  SearchResult.swift
//  Yelp
//
//  Created by Truong Vo Duy Thuc on 10/22/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import Foundation

class SearchResult: NSObject {
    let total: Int?
    let businesses: [Business]!
    
    init(total: Int, businesses: [Business]!) {
        self.total = total
        self.businesses = businesses
    }
}
