//
//  ArchivosLocalesRouter.swift
//  ILovePdfInterview
//
//  Created by usuario on 6/1/21.
//

import Foundation
import UIKit


class ArchivosLocalesRouter{
    
    func goToArchivosLocales(navigationViewController: UINavigationController?){
        if let navigation = navigationViewController{
            let storyboard = UIStoryboard(name: "ArchivosLocales", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "archivosLocalesStoryboard") as! ArchivosLocalesViewController
            let presenter = ArchivosLocalesPresenter()
            vc.presenter = presenter
            navigation.pushViewController(vc, animated: true)
        }
    }
    
}
