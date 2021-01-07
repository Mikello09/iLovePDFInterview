//
//  SeleccionarArchivosViewController.swift
//  ILovePdfInterview
//
//  Created by usuario on 6/1/21.
//

import Foundation
import UIKit

class SeleccionarArchivosViewController: BaseViewController{
    
    var presenter: SeleccionarArchivosPresenter?
    var fromFiles: [FilesFrom] = []
    
    let columnLayout = CustomColumnFlow(
            cellsPerRow: 3,
            minimumInteritemSpacing: 16,
            minimumLineSpacing: 16,
            sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    
    @IBOutlet weak var filesFromCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        
        presenter?.getChooseFilesFrom()
    }
    
    func setUpCollectionView(){
        filesFromCollection?.collectionViewLayout = columnLayout
        filesFromCollection?.contentInsetAdjustmentBehavior = .always
        filesFromCollection.register(UINib.init(nibName: "FilesFromCell", bundle: nil), forCellWithReuseIdentifier: "FilesFromCell")
    }
    
}

extension SeleccionarArchivosViewController: SeleccionarArchivosPresenterProtocol{
    func showFilesFrom(from: [FilesFrom]) {
        fromFiles = from
    }
}

extension SeleccionarArchivosViewController: UICollectionViewDataSource, UICollectionViewDelegate, FilesFromCellProtocol{
    /*
     Here, depending in the FilesFrom selected, we would send the user to different file pickers. For the moment, only LocalFiles can be selected
     */
    func fromFileClicked(from: FilesFrom) {
        from.route(navigationController: self.navigationController)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fromFiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilesFromCell", for: indexPath) as! FilesFromCell
        cell.configure(fromFile: fromFiles[indexPath.row], delegate: self)
        return cell
    }
    
    
}
