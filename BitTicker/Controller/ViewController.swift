//
//  ViewController.swift
//  BitTicker
//
//  Created by skyit on 2/27/19.
//  Copyright © 2019 skyit. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var inputText: UITextField!
//    @IBOutlet weak var tradingValue: UILabel!
    @IBOutlet weak var lblCurrPairId: UILabel!
    @IBOutlet weak var lblLastTradeValue: UILabel!
    @IBOutlet weak var lblLowestAsk: UILabel!
    @IBOutlet weak var lblHighestbid: UILabel!
    @IBOutlet weak var lblPerchange: UILabel!
    @IBOutlet weak var lblBaseCurr: UILabel!
    @IBOutlet weak var lblQuoteCurr: UILabel!
    @IBOutlet weak var lblIsFrozen: UILabel!
    @IBOutlet weak var lblHighesttradePrice: UILabel!
    @IBOutlet weak var lblLowestTradePrice: UILabel!
    var finalArray:[Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BitTicker"

        fetchTickerData()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func fetchTickerData() {
        Poloniex.Live.Subscribe(channel: .ticker, delegate: onTicker)
    }
    
    func onTicker(message: String) {
        DispatchQueue.main.async {
            
            let data1 = message.data(using: .utf8)!
            let peoplesArray = try! JSONSerialization.jsonObject(with: data1, options : .allowFragments) as? [Any]
            
            for peopleDict in peoplesArray!{
                if let dict = peopleDict as? [Any] {
                    let ticketItem = Ticker()
                    
                    for (index, element) in dict.enumerated() {
                        switch(index){
                        case 0:
                            ticketItem.currency_pair_id = element as? Int
                            self.lblCurrPairId.text =  "Currency Pair Id : \(String(ticketItem.currency_pair_id!))"
                            break
                        case 1:
                            ticketItem.last_trade_price = element as? String
                            self.lblLastTradeValue.text = "Last Trade Value : \(ticketItem.last_trade_price!)"
                            
                            if let enterValue = self.inputText.text {
                                
                                let a1 = enterValue.isEmpty ? 0.0 : Double(enterValue)!
                                let a2 = Double(element as! String)!
                                
                                if(a1 < a2){
                                    self.lblLastTradeValue.textColor = .green
                                }else {
                                    self.lblLastTradeValue.textColor = .red
                                }
                            }
                            
                            break
                        case 2:
                            ticketItem.lowest_ask = element as? String
                            self.lblLowestAsk.text =  "Lowest Ask : \(ticketItem.lowest_ask!)"
                            
                            break
                        case 3:
                            ticketItem.highest_bid = element as? String
                            self.lblHighestbid.text = "Highest Bid : \(ticketItem.highest_bid!)"
                            
                            break
                        case 4:
                            ticketItem.percent_change_in_last_24_hours = element as? String
                            self.lblPerchange.text = "Percent change last 24 hr : \(ticketItem.percent_change_in_last_24_hours!)"
                            
                            break
                        case 5:
                            ticketItem.base_currency_volume_in_las_24_hours = element as? String
                            self.lblBaseCurr.text = "Base currency volume last 24 hr : \(ticketItem.base_currency_volume_in_las_24_hours!)"
                            
                            break
                        case 6:
                            ticketItem.quote_currency_volume_in_last_24_hours = element as? String
                            self.lblQuoteCurr.text = "Quote currency volume last 24 hr : \(ticketItem.quote_currency_volume_in_last_24_hours!)"
                            
                            break
                        case 7:
                            ticketItem.is_frozen =  element as? Int
                            self.lblIsFrozen.text = "Is frozen : \(ticketItem.is_frozen ?? 0)"
                            
                            break
                        case 8:
                            ticketItem.highest_trade_price_in_last_24_hours = element as? String
                            self.lblHighesttradePrice.text = "Highest trade price last 24 hr : \(ticketItem.highest_trade_price_in_last_24_hours!)"
                            
                            break
                        case 9:
                            ticketItem.lowest_trade_price_in_last_24_hours = element as? String
                            self.lblLowestTradePrice.text = "Lowest trade price last 24 hr : \(ticketItem.lowest_trade_price_in_last_24_hours!)"
                            
                            break
                        default:
                            break
                        }
                    }
                }
            }
        }
    }
}

