//
//  CompletadoRouter.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit


class CompletadoRouter{
    
    func goToCompletado(navigationController: UINavigationController?){
        if let navigation = navigationController{
            let storyboard = UIStoryboard(name: "Completado", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "completadoStoryboard") as! CompletadoViewController
            let presenter = CompletadoPresenter()
            presenter.delegate = vc
            vc.presenter = presenter
            navigation.pushViewController(vc, animated: true)
        }
    }
    
}
