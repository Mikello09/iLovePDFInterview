//
//  VisorArchivosViewController.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit
import PDFKit


class VisorArchivosViewController: BaseViewController{
    
    
    var file: URL?//localy saved document url
    @IBOutlet weak var fileContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle(titulo: file?.lastPathComponent ?? "")
        showPdf()
    }
    
    func showPdf(){
        if let data = file?.getData(){
            let pdfview = PDFView(frame:self.fileContainer.bounds)
            pdfview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            pdfview.autoScales = true
            self.fileContainer.addSubview(pdfview)
            let doc = PDFDocument(data: data)
            pdfview.document = doc
        }
    }
    
}
