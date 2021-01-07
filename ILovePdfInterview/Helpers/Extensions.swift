//
//  Extensions.swift
//  ILovePdfInterview
//
//  Created by usuario on 6/1/21.
//

import Foundation
import UIKit
import PDFKit

extension String{
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

extension UIView{
    func addShadowInContainerView(borderWidth: CGFloat = 0.1,opacity: Float = 0.2) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 3
        self.layer.borderColor = UIColor.Gris.cgColor
        self.layer.borderWidth = borderWidth
        self.addShadow(offset: CGSize.init(width: 0, height: 3), color: .Negro, radius: 3.0, opacity: opacity)
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}

extension UIButton{
    func enabledButton(){
        self.isEnabled = true
        self.setTitleColor(.BotonTituloColor, for: .normal)
        self.backgroundColor = .Rojo
        self.layer.cornerRadius = 10
    }
    
    func disabledButton(){
        self.isEnabled = false
        self.setTitleColor(.BotonTituloColor, for: .disabled)
        self.backgroundColor = .Gris
        self.layer.cornerRadius = 10
    }
}

extension URL{
    func getTitle() -> String{
        return self.lastPathComponent
    }
    
    func getMiniatura() -> UIImage?{
        guard let doc = PDFDocument(url: self) else {return nil}
        guard let page = doc.page(at: 0) else {return nil}
        return page.thumbnail(of: CGSize(width: 768, height: 1024), for: .cropBox)
    }
    
    func getFileDetails() -> String{
        do {
            let resources = try self.resourceValues(forKeys:[.fileSizeKey])
            return "\(self.pathExtension) \((resources.fileSize ?? 0).toFileSize())"
        } catch {
            return ""
        }
    }
    
    func getData() -> Data?{
        do{
            let data = try Data(contentsOf: self)
            return data
        }catch{
            return nil
        }
    }
}

extension Data {

    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}

extension Int {
    func toFileSize() -> String{
        return ByteCountFormatter.string(fromByteCount: Int64(self), countStyle: .file)
    }
}


