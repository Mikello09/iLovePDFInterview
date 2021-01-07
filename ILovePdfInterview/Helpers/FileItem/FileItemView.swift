//
//  FileItemView.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit

protocol FileItemViewProtocol {
    func fileSelected()
}

class FileItemView: UIView{
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var detalles: UILabel!
    
    var delegate: FileItemViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.translatesAutoresizingMaskIntoConstraints = false
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("FileItemView", owner: self, options: nil)
        self.frame = view.bounds
        self.addSubview(self.view)
    }
    
    func configure(titulo: String, detalles: String, imagen: UIImage?, delegate: FileItemViewProtocol){
        self.delegate = delegate
        self.titulo.text = titulo
        self.detalles.text = detalles
        self.imagen.image = imagen
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(fileItemClicked))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        
    }
    
    @objc
    func fileItemClicked(){
        delegate?.fileSelected()
    }
}
