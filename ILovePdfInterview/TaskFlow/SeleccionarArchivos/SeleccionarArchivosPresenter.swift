//
//  SeleccionarArchivosPresenter.swift
//  ILovePdfInterview
//
//  Created by usuario on 6/1/21.
//

import Foundation
import UIKit

/*
 All the places where we can import files to the TaskFlow
 */
enum FilesFrom {
    case device
    case googleDrive
    case dropbox
    
    func getTitulo() -> String{
        switch self {
            case .device:
                if UIDevice.current.userInterfaceIdiom == .phone {
                    return "iphone".localized
                } else {
                    return "ipad".localized
                }
                
            case .googleDrive:
                return "googleDrive".localized
            case .dropbox:
                return "dropbox".localized
            }
    }
    
    func getImage() -> String{
        switch self {
            case .device:
                return "folder.fill"
            case .googleDrive:
                return ""
            case .dropbox:
                return ""
            }
    }
    
    func route(navigationController: UINavigationController?){
        switch self {
        case .device:
            ArchivosLocalesRouter().goToArchivosLocales(navigationViewController: navigationController)
        case .googleDrive:
            return
        case .dropbox:
            return
        }
    }
}

protocol SeleccionarArchivosPresenterProtocol {
    func showFilesFrom(from: [FilesFrom])
}

class SeleccionarArchivosPresenter{
    
    var delegate: SeleccionarArchivosPresenterProtocol?
    
    /*
     Here we can take the decission of not showing all the FilesFrom for an specific situation.
     */
    func getChooseFilesFrom(){
        delegate?.showFilesFrom(from: [.device])
    }
    
}
