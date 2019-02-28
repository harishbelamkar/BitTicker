//
//  TickerViewController.swift
//  BitTicker
//
//  Created by skyit on 2/28/19.
//  Copyright © 2019 skyit. All rights reserved.
//

import UIKit



class TickerViewController: UIViewController , UITextFieldDelegate{
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var inputtext: UITextField!
    @IBOutlet weak var currencyPair: UITextField!
    @IBOutlet weak var lastTradeValue: UITextField!
    @IBOutlet weak var lowestAsk: UITextField!
    @IBOutlet weak var highestBid: UITextField!
    @IBOutlet weak var percentageChange: UITextField!
    @IBOutlet weak var baseCurrency: UITextField!
    @IBOutlet weak var quoteCurrency: UITextField!
    @IBOutlet weak var lowestTradePrice: UITextField!
    
    @IBOutlet weak var highestTradePrice: UITextField!
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
                            self.currencyPair.text = String(ticketItem.currency_pair_id!)
                            break
                        case 1:
                            ticketItem.last_trade_price = element as? String
                            self.lastTradeValue.text = ticketItem.last_trade_price
                            if let enterValue = self.inputtext.text {
                                
                                let a1 = enterValue.isEmpty ? 0.0 : Double(enterValue)!
                                let a2 = Double(element as! String)!
                                
                                if(a1 < a2){
                                    self.lastTradeValue.textColor = .green
                                    self.arrowImage.image = UIImage(named: "up-arrow.png")
                                }else {
                                    self.lastTradeValue.textColor = .red
                                    self.arrowImage.image = UIImage(named: "down-arrow.png")
                                }
                            }
                            break
                        case 2:
                            ticketItem.lowest_ask = element as? String
                            self.lowestAsk.text = ticketItem.lowest_ask
                            break
                        case 3:
                            ticketItem.highest_bid = element as? String
                            self.highestBid.text = ticketItem.highest_bid
                            break
                        case 4:
                            ticketItem.percent_change_in_last_24_hours = element as? String
                            self.percentageChange.text = ticketItem.percent_change_in_last_24_hours
                            let a1 = Double(ticketItem.percent_change_in_last_24_hours!)!
                            if(a1 > 0.000){
                                self.percentageChange.textColor = .green
                            }else {
                                self.percentageChange.textColor = .red
                            }
                            break
                        case 5:
                            ticketItem.base_currency_volume_in_las_24_hours = element as? String
                            self.baseCurrency.text = ticketItem.base_currency_volume_in_las_24_hours
                            break
                        case 6:
                            ticketItem.quote_currency_volume_in_last_24_hours = element as? String
                            self.quoteCurrency.text = ticketItem.quote_currency_volume_in_last_24_hours
                            break
                        case 7:
                            ticketItem.is_frozen =  element as? Int
                            break
                        case 8:
                            ticketItem.highest_trade_price_in_last_24_hours = element as? String
                            self.highestTradePrice.text = ticketItem.highest_trade_price_in_last_24_hours
                            break
                        case 9:
                            ticketItem.lowest_trade_price_in_last_24_hours = element as? String
                            self.lowestTradePrice.text = ticketItem.lowest_trade_price_in_last_24_hours
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


