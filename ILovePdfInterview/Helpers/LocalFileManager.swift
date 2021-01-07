//
//  LocalFileManager.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit


class LocalFileManager{
    
    func getDirectoryUrl() -> URL{
        guard let directoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("directoryError".localized)
        }
        return directoryUrl
    }
    
    func saveFile(fileName: String, data: Data){
        var url = getDirectoryUrl()
        url.appendPathComponent(fileName, isDirectory: false)
        
        do {
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getAllFiles() -> [URL]{
        let url = getDirectoryUrl()
        
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("directoryNotExist".localized)
        }
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            return directoryContents
        }catch{
            return []
        }
    }
    
}
