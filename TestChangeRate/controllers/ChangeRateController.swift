//
//  ChangeRateController.swift
//  TestChangeRate
//
//  Created by Shidong Lin on 9/21/19.
//  Copyright © 2019 Shidong Lin. All rights reserved.
//

import Foundation

enum GetChangeRateResult {
    case success(Double)
    case error
}

protocol ChangeRateControllerProtocol {
    func fetchCurrencies(_ completion: @escaping (() -> Void))
    func fetchChangeRate(_ currency1: Currency, _ currency2: Currency, _ completion: @escaping ((GetChangeRateResult) -> Void))
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

    func fetchChangeRate(_ currency1: Currency, _ currency2: Currency, _ completion: @escaping ((GetChangeRateResult) -> Void)) {
        let urlString = "https://api.coinbase.com/v2/exchange-rates?currency=\(currency1.id)"
        guard let url = URL(string: urlString) else {
            completion(.error)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.error)
                return
            }
            do {
                let changeRatesResponse = try JSONDecoder().decode(GetChangeRateResponse.self, from: data)
                let ratesData = changeRatesResponse.data
                if let rate = ratesData.rates[currency2.id], let numRate = Double(rate) {
                    completion(.success(numRate))
                } else {
                    completion(.error)
                }
            } catch {

            }
        }.resume()
    }
}
