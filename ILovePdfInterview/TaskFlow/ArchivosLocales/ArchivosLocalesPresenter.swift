//
//  ArchivosLocalesPresenter.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit


class ArchivosLocalesPresenter{
    
    /*
     Every time a file is seleceted TaskFlow url is updated
     */
    func guardarUrl(url: URL){
        TaskFlowManager.shared.url = url
    }
    
}
