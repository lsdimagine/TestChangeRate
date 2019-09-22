//
//  Currency.swift
//  TestChangeRate
//
//  Created by Shidong Lin on 9/21/19.
//  Copyright © 2019 Shidong Lin. All rights reserved.
//

import Foundation

struct GetCurrenciesResponse: Codable {
    let data: [Currency]
}

struct Currency: Codable {
    let id: String
}
