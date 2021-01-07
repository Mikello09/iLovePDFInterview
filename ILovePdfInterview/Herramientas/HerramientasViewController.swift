//
//  HerramientasViewController.swift
//  ILovePdfInterview
//
//  Created by usuario on 6/1/21.
//

import Foundation
import UIKit


class HerramientasViewController: BaseViewController{
    
    var presenter: HerramientasPresenter?
    
    //UICollectionView
    let columnLayout = CustomColumnFlow(
            cellsPerRow: 3,
            minimumInteritemSpacing: 16,
            minimumLineSpacing: 16,
            sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    var herramientas: [Herramienta] = []
    @IBOutlet weak var herramientasCollectionView: UICollectionView!
    
    var fileType: FileType = .pdf//This param could vary when the flow is upside down: first choosing file and then Herramienta. A Router would be create for that.

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        registerHerramientasCells()
        
        presenter?.getHerramientas(fileType: fileType)
    }
    
    func configureViewController(){
        //this config is done here because this module has not Router
        presenter = HerramientasPresenter()
        presenter?.delegate = self
    }
    
    func registerHerramientasCells(){
        herramientasCollectionView?.collectionViewLayout = columnLayout
        herramientasCollectionView?.contentInsetAdjustmentBehavior = .always
        herramientasCollectionView.register(UINib.init(nibName: "HerramientaCell", bundle: nil), forCellWithReuseIdentifier: "HerramientaCell")
    }
    
}

extension HerramientasViewController: HerramientasPresenterProtocol{
    func showHerramientas(herramientas: [Herramienta]) {
        self.herramientas = herramientas
        herramientasCollectionView.reloadData()
    }
}

extension HerramientasViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, HerramientaCellProtocol{
    /*
     TaskFlow starts here. Firstly, Herramienta is set and then we move to the next step.
     */
    func onHerramientaClicked(herramienta: Herramienta) {
        TaskFlowManager.shared.herramienta = herramienta.tipo
        SeleccionarArchivosRouter().goToSeleccionarArchivos(navigationViewController: self.navigationController)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return herramientas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HerramientaCell", for: indexPath) as! HerramientaCell
        cell.configure(herramienta: herramientas[indexPath.row], delegate: self)
        return cell
    }
    
}
