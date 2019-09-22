//
//  ChangeRate.swift
//  TestChangeRate
//
//  Created by Shidong Lin on 9/21/19.
//  Copyright © 2019 Shidong Lin. All rights reserved.
//

import Foundation

struct GetChangeRateResponse: Codable {
    let data: ChangeRates
}

struct ChangeRates: Codable {
    let currency: String
    let rates: [String: String]
}
