//
//  NivelCompresionViewController.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit


class NivelCompresionViewController: BaseViewController{
    
    var presenter: NivelCompresionPresenter?
    
    var compresiones: [Compresion] = []
    @IBOutlet weak var compresionTabla: UITableView!
    @IBOutlet weak var comprimirBoton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        presenter?.getCompresiones()
    }
    
    func setUpView(){
        compresionTabla.register(UINib.init(nibName: "CompresionItemCell", bundle: nil), forCellReuseIdentifier: "CompresionItemCell")
        comprimirBoton.setTitle("comprimir".localized, for: .normal)
        comprimirBoton.enabledButton()
    }
    
    @IBAction func onComprimirSelected(_ sender: UIButton) {
        CompletadoRouter().goToCompletado(navigationController: self.navigationController)
    }
    
}

extension NivelCompresionViewController: NivelCompresionPresenterProtocol{
    func showCompresiones(compresiones: [Compresion]) {
        self.compresiones = compresiones
        compresionTabla.reloadData()
    }
}

extension NivelCompresionViewController: UITableViewDelegate, UITableViewDataSource, CompresionItemCellProtocol{
    func compresionSeleccionado(index: Int) {
        presenter?.compresionSeleccionado(indice: index)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return compresiones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompresionItemCell", for: indexPath) as! CompresionItemCell
        cell.configure(compresion: compresiones[indexPath.row].tipo,
                       seleccionado: compresiones[indexPath.row].seleccionado,
                       index: indexPath.row,
                       delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad{
            return 160
        } else {
            return 70
        }
    }
    
    
}
