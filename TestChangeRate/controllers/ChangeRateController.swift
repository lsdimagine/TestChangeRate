//
//  ChangeRateController.swift
//  TestChangeRate
//
//  Created by Shidong Lin on 9/21/19.
//  Copyright © 2019 Shidong Lin. All rights reserved.
//

import Foundation

protocol ChangeRateControllerProtocol {
    func fetchCurrencies(_ completion: @escaping (() -> Void))
    func fetchChangeRate(_ currency: Currency, _ completion: @escaping (() -> Void))
    var currencies: [Currency] { get }
}

class ChangeRateController: ChangeRateControllerProtocol {
    static let shared = ChangeRateController()
    var currencies = [Currency]()

    func fetchCurrencies(_ completion: @escaping (() -> Void)) {
        let urlString = "https://api.coinbase.com/v2/currencies"
        guard let url = URL(string: urlString) else {
            completion()
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion()
                return
            }
            do {
                let currenciesResponse = try JSONDecoder().decode(GetCurrenciesResponse.self, from: data)
                self.currencies = currenciesResponse.data
                completion()
            } catch {

            }
        }.resume()
    }

    func fetchChangeRate(_ currency: Currency, _ completion: @escaping (() -> Void)) {
        
    }
}
