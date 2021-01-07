//
//  ArchivosViewController.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit


class ArchivosViewController: BaseViewController{
    
    
    var presenter: ArchivosPresenter?
    var archivosLocales: [LocalFile] = []
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var archivosTabla: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*
         Everytime this views appears we must ask for local files searching for a change in the directory
         */
        presenter?.getLocalFiles()
    }
    
    func setUpView(){
        emptyLabel.text = "archivosVacios".localized
        archivosTabla.register(UINib.init(nibName: "ArchivoCell", bundle: nil), forCellReuseIdentifier: "ArchivoCell")
    }
    
    func configureView(){
        //this config is done here because this module has not Router
        presenter = ArchivosPresenter()
        presenter?.delegate = self
    }
    
}

extension ArchivosViewController: ArchivosPresenterProtocol{
    func showEmpty() {
        archivosTabla.isHidden = true
        emptyLabel.isHidden = false
    }
    
    func showFiles(files: [LocalFile]) {
        emptyLabel.isHidden = true
        archivosTabla.isHidden = false
        archivosLocales = files
        archivosTabla.reloadData()
    }
}

extension ArchivosViewController: UITableViewDelegate, UITableViewDataSource, ArchivoCellProtocol{
    func archivoCellSelected(file: LocalFile) {
        VisorArchivosRouter().goToVisorArchivos(navigationController: self.navigationController,
                                                file: file.url)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return archivosLocales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArchivoCell", for: indexPath) as! ArchivoCell
        cell.configure(file: archivosLocales[indexPath.row],
                       delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad{
            return 160
        } else {
            return 80
        }
    }
    
}
