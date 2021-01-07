//
//  NivelCompresionRouter.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit


class NivelCompresionRouter{
    
    func goToNivelCompresion(navigationController: UINavigationController?){
        if let navigation = navigationController{
            let storyboard = UIStoryboard(name: "NivelCompresion", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "nivelCompresionStoryboard") as! NivelCompresionViewController
            let presenter = NivelCompresionPresenter()
            presenter.delegate = vc
            vc.presenter = presenter
            navigation.pushViewController(vc, animated: true)
        }
    }
    
}
