//
//  ViewController.swift
//  CacheLRU_Demo
//
//  Created by 享贞002 on 2019/3/4.
//  Copyright © 2019 享贞002. All rights reserved.
//

import UIKit
import CacheLRU

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let cache = CacheLRU<String, Int>.init(capacity : 5)
        cache.setValue(10, for: "key")
        print(cache.getValue(for: "key") ?? 0)
        
    }


}

