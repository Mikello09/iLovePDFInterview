//
//  VisorArchivosRouter.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit


class VisorArchivosRouter{
    
    func goToVisorArchivos(navigationController: UINavigationController?, file: URL){
        if let navigation = navigationController{
            let storyboard = UIStoryboard(name: "VisorArchivos", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "visorArchivosStoryboard") as! VisorArchivosViewController
            vc.file = file
            navigation.pushViewController(vc, animated: true)
        }
    }
    
}
