//
//  MainRouter.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit


class MainRouter{
    
    func goToMain(navigationController: UINavigationController?){
        if let navigation = navigationController{
            navigation.tabBarController?.selectedIndex = 0
            navigation.popToRootViewController(animated: false)
        }
        
        
    }
    
}
