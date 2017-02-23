//
//  ViewController.swift
//  BeamsReflection
//
//  Created by jufina on 23.02.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let beamsView = BeamsView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        beamsView.frame = self.view.bounds
        beamsView.backgroundColor = Constants.Appearance.backgroundColor
        self.view.addSubview(beamsView)
    }
    
    
}

