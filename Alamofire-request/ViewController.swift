//
//  ViewController.swift
//  Alamofire-request
//
//  Created by Carlos on 1/16/18.
//  Copyright © 2018 Carlos-iv. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var priceLabel: UILabel!
    static let kbpi = "bpi"
    static let kusd = "USD"
    static let krate = "rate_float"
    var activityIndicator = UIActivityIndicatorView()         //Activity indicator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceLabel.text = "..."
        
        self.view.addSubview(activityIndicator)         //Activity indicator
        
        activityIndicator.startAnimating()         //Activity indicator
        
        //Request with Validation
        Alamofire.request("https://api.coindesk.com/v1/bpi/currentprice.json").validate().responseJSON{
            response in
            switch response.result {
            case .success:
                print("Validation Successful")
                self.activityIndicator.stopAnimating()          //Activity indicator
                
                let alertView = UIAlertController(title:"Success", message:"valid rquest", preferredStyle: .actionSheet)
                let cancel = UIAlertAction(title:"Cancel", style:.destructive)
                alertView.addAction(cancel)
                
                self.present(alertView, animated: true , completion: nil)
                
            case .failure(let error):
                print(error)
                self.activityIndicator.stopAnimating()         //Activity indicator
                
                let alertView = UIAlertController(title:"Error", message:"Server Error", preferredStyle: .actionSheet)
                let cancel = UIAlertAction(title:"Cancel", style:.destructive)
                alertView.addAction(cancel)
                self.present(alertView, animated: true , completion: nil)
                
                
            }
            print(response)
            if let bitcoinJSON = response.value{
                
                let bitcoinObject:Dictionary = bitcoinJSON as! Dictionary<String,Any>
                let bpiObject:Dictionary = bitcoinObject[ViewController.kbpi] as! Dictionary<String,Any>
                let usdObject = bpiObject[ViewController.kusd] as! Dictionary<String,Any>
                let rate:Float = usdObject[ViewController.krate] as! Float
                self.priceLabel.text = "$\(rate)"
            }
        }
        
        
        // Both calls are equivalent
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

    
