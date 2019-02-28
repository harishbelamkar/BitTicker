//
//  TickerModel.swift
//  BitTicker
//
//  Created by skyit on 2/27/19.
//  Copyright © 2019 skyit. All rights reserved.
//

import Foundation

struct RegisterUser:Codable {
    var firstName: String
   var lastName: String
   var emailId: String
   var password: String
    
    init(firstName: String, lastName: String,emailId: String, password: String){
        self.firstName = firstName
        self.lastName = lastName
        self.emailId = emailId
        self.password = password
    }
}
class Ticker {
    var currency_pair_id: Int?
    var last_trade_price: String?
    var lowest_ask: String?
    var highest_bid: String?
    var percent_change_in_last_24_hours: String?
    var base_currency_volume_in_las_24_hours: String?
    var quote_currency_volume_in_last_24_hours: String?
    var is_frozen: Int?
    var highest_trade_price_in_last_24_hours: String?
    var lowest_trade_price_in_last_24_hours: String?
}
