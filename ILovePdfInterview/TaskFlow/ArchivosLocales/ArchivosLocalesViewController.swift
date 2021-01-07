//
//  ArchivosLocalesViewController.swift
//  ILovePdfInterview
//
//  Created by usuario on 6/1/21.
//

import Foundation
import UIKit
import CoreServices


class ArchivosLocalesViewController: BaseViewController{
    
    var presenter: ArchivosLocalesPresenter?
    
    @IBOutlet weak var selectedFile: FileItemView!
    @IBOutlet weak var continuarBoton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initDocs()//init Docs in viewDidAppear because the viewController must be visible before doing a present to another viewController
    }
    
    func setUpView(){
        continuarBoton.setTitle("continuar".localized, for: .normal)
        continuarBoton.setTitle("continuar".localized, for: .disabled)
        continuarBoton.disabledButton()
    }
    
    @IBAction func onContinuarClicked(_ sender: UIButton) {
        /*
         Only if there is a file selected would be button enabled
         */
        if sender.isEnabled{
            NivelCompresionRouter().goToNivelCompresion(navigationController: self.navigationController)
        }
    }
    
}

extension ArchivosLocalesViewController: FileItemViewProtocol{
    func fileSelected() {
        //nothing for now
    }
}

extension ArchivosLocalesViewController : UIDocumentPickerDelegate {
    func initDocs() {
        let pickerController = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        pickerController.delegate = self
        present(pickerController, animated: false, completion: nil)
    }

    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let url = urls.first {
            selectedFile.configure(titulo: url.lastPathComponent,
                                   detalles: url.getFileDetails(),
                                   imagen: url.getMiniatura(),
                                   delegate: self)
            selectedFile.isHidden = false
            continuarBoton.enabledButton()
            presenter?.guardarUrl(url: url)
        }
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("url = \(url)")
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}
