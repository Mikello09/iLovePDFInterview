//
//  BaseViewController.swift
//  ILovePdfInterview
//
//  Created by usuario on 6/1/21.
//

import Foundation
import UIKit


class BaseViewController: UIViewController{
    
    let waittingSpinner: UIActivityIndicatorView = {
        let loginSpinner = UIActivityIndicatorView(style: .large)
        loginSpinner.translatesAutoresizingMaskIntoConstraints = false
        loginSpinner.hidesWhenStopped = true
        return loginSpinner
    }()
    
    func prepareWaittingSpinner(){
        self.view.addSubview(waittingSpinner)
        waittingSpinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        waittingSpinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func startAnimating(){
        DispatchQueue.main.async {
            self.waittingSpinner.startAnimating()
        }
    }
    
    func stopAnimating(){
        DispatchQueue.main.async {
            self.waittingSpinner.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectionNavigationToShow()
        prepareWaittingSpinner()
    }
    
    func selectionNavigationToShow(){
        if let viewController = navigationController?.viewControllers.last{
            switch viewController {
            case is HerramientasViewController:
                mainNavigationBar()
                setNavigationTitle(titulo: "herramientas".localized)
            case is ArchivosViewController:
                mainNavigationBar()
                setNavigationTitle(titulo: "archivos".localized)
            case is SeleccionarArchivosViewController:
                mainNavigationBar()
                setNavigationTitle(titulo: "seleccionarArchivos".localized)
            case is ArchivosLocalesViewController:
                mainNavigationBar()
                setNavigationTitle(titulo: UIDevice.current.userInterfaceIdiom == .phone ? "iphone".localized : "ipad".localized)
            case is NivelCompresionViewController:
                mainNavigationBar()
                setNavigationTitle(titulo: "nivelCompresion".localized)
            case is CompletadoViewController:
                mainNavigationBarWithoutBack()
                setNavigationTitle(titulo: "completado".localized)
            case is VisorArchivosViewController:
                mainNavigationBar()
            default:
                self.navigationController?.isNavigationBarHidden = false
            }
        } else {
            self.navigationController?.isNavigationBarHidden = false
        }
    }
    
    func mainNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .NavigationBarColor
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.clear
        
        let backItem = UIBarButtonItem()
        backItem.tintColor = .Negro
        navigationItem.backBarButtonItem = backItem
        
        statusBarBackground()
    }
    
    func mainNavigationBarWithoutBack(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .NavigationBarColor
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.clear
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        statusBarBackground()
    }
    
    func statusBarBackground(){
        let view = UIView(frame: UIApplication.shared.statusBarFrame)
        view.backgroundColor = .NavigationBarColor
        self.view.addSubview(view)
    }
    
    func setNavigationTitle(titulo: String){
        let titleLabel = UILabel()
        let font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.font = font
        titleLabel.textColor = .Negro
        titleLabel.text = titulo
        self.navigationItem.titleView = titleLabel
    }
    
}
