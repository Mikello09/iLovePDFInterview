//
//  SeleccionarArchivosRouter.swift
//  ILovePdfInterview
//
//  Created by usuario on 6/1/21.
//

import Foundation
import UIKit

class SeleccionarArchivosRouter{
    
    func goToSeleccionarArchivos(navigationViewController: UINavigationController?){
        if let navigation = navigationViewController{
            let storyboard = UIStoryboard(name: "SeleccionarArchivos", bundle: nil)
            let vc: SeleccionarArchivosViewController = storyboard.instantiateViewController(withIdentifier: "seleccionarArchivosStoryboard") as! SeleccionarArchivosViewController
            let presenter = SeleccionarArchivosPresenter()
            presenter.delegate = vc
            vc.presenter = presenter
            navigation.pushViewController(vc, animated: true)
        }
    }
    
}
