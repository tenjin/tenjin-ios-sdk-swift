//
//  ViewController.swift
//  tenjin-ios-sdk-swift
//
//  Created by Van Pham on 4/29/18.
//  Copyright © 2018 Tenjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        TenjinSDK.init("YOUR API KE")
        TenjinSDK.connect();
        
        TenjinSDK.
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

