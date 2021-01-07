//
//  CompletadoViewController.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit


class CompletadoViewController: BaseViewController{
    
    var presenter: CompletadoPresenter?
    
    @IBOutlet weak var completadoView: UIView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var detalles: UILabel!
    @IBOutlet weak var irArchivoBoton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimating()
        presenter?.ejecutarHerramienta()
    }
    
    @IBAction func onClickIrAArchivo(_ sender: UIButton) {
        MainRouter().goToMain(navigationController: self.navigationController)
    }
}
/*
 UI updates must be encapsulated in DispathQueue.main because the download of the file is done in background
 */
extension CompletadoViewController: CompletadoPresenterProtocol{
    func showCompletado(beforeSize: String, actualSize: String, percentaje: String) {
        stopAnimating()
        DispatchQueue.main.async {
            self.titulo.text = "completadoOK".localized
            self.imagen.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.Verde)
            self.detalles.text = "\("pdfcomprimido".localized)\n\(beforeSize) -> \(actualSize)\n\(percentaje)% \("menosTamano".localized)"
            self.irArchivoBoton.setTitle("irAlArchivo".localized, for: .normal)
            self.irArchivoBoton.enabledButton()
            self.completadoView.isHidden = false
        }
    }
    
    func showError(error: ILPDFError) {
        stopAnimating()
        DispatchQueue.main.async {
            self.titulo.text = "noCompletado".localized
            self.imagen.image = UIImage(systemName: "xmark.circle.fill")?.withTintColor(.Rojo)
            self.detalles.text = "\(error.message)"
            self.irArchivoBoton.setTitle("irAlArchivo".localized, for: .normal)
            self.irArchivoBoton.enabledButton()
            self.completadoView.isHidden = false
        }
    }
    
    
}
