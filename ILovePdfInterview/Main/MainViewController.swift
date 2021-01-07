//
//  MainViewController.swift
//  ILovePdfInterview
//
//  Created by usuario on 5/1/21.
//

import Foundation
import UIKit


class MainViewController: UITabBarController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setItemTitles()
    }
    
    
    private func setItemTitles(){
        tabBar.items?[0].title = "archivos".localized
        tabBar.items?[1].title = "herramientas".localized
    }
    
}
