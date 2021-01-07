//
//  BaseRouter.swift
//  ILovePdfInterview
//
//  Created by usuario on 5/1/21.
//

import Foundation
import UIKit
import CoreServices


enum HttpMethod: String{
    case get = "GET"
    case post = "POST"
}
typealias JSONDictionary = [String: Any]
/*
 A more precise error treatment would be needed. For now, as errors are not homogeneous, I have a created an struct for throwing message and status
 */
struct ILPDFError{
    var message: String
    var status: Int = 500
}
let genericError: ILPDFError = ILPDFError(message: "generic_error".localized)

protocol BaseWorkerProtocol {
    func showError(error: ILPDFError)
}

class BaseWorker{
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    /*
     Special call for downloading files from URL. URLSession.shared.downloadTask is prepared for it and makes the download in the background
     */
    func crearDownloadLlamada(url: String,
                              token: String,
                              completion: @escaping (URL?, ILPDFError?) -> Void){
        if let urlComponents = URLComponents(string: url) {
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.httpMethod = "GET"
            urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
            print(urlRequest.description)
            let task = URLSession.shared.downloadTask(with: urlRequest) { localURL, urlResponse, error in
                if let localURL = localURL {
                    completion(localURL,nil)
                } else {
                    completion(nil, genericError)
                }
            }
            task.resume()
        }
        
    }
    /*
     method: GET or POST
     url: server url as String
     respuesta: Codable response for successfull call
     errorRespuesta: This would have to be an homogenous error treatmet. As far as I have been able to see, different endpoints throw different error structures. For now I only pass AuthError structure to get Unauthorized error and renew the Bearer token of JWT.
     params: JSON structure parameters
     uploadFile: When Upload Task is executed the file must be sent. A file can not be treated as a normal body param so it must be send as multipart/form-data.
     bearer: JWT token
     completion: the completion method where result and error is passed
     */
    func crearLlamada<T: Codable, AuthError: Codable>(
        method: HttpMethod,
        url: String,
        respuesta: T,
        errorRespuesta: AuthError,
        params: [String: Any] = [:],
        uploadFile: URL? = nil,
        bearer: String? = nil,
        completion: @escaping (T?,ILPDFError?) -> Void){
        
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: url) {
            
            if method == .get{
                var paramsToAppend = ""
                for param in params{
                    paramsToAppend.append("\(param.key)=\(param.value)&")
                }
                urlComponents.query = paramsToAppend
            }
            
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.httpMethod = method.rawValue
            
            if method == .post{
                
                if let file = uploadFile{
                    do{
                        let boundary = generateBoundaryString()
                        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

                        let fileURL = file
                        urlRequest.httpBody = try createBody(with: params, filePathKey: "file", urls: [fileURL], boundary: boundary)
                    } catch{
                        completion(nil, genericError)
                    }
                    
                } else {
                    do {
                        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
                    } catch {
                        completion(nil,genericError)
                    }
                    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
                }
            }
            
            //headers
            if let authenticationToken = bearer{
                urlRequest.setValue("Bearer " + authenticationToken, forHTTPHeaderField: "Authorization")
            }
            
            
            print(urlRequest.description)
            dataTask = defaultSession.dataTask(with: urlRequest){ [weak self] data, response, error in
                defer{
                    self?.dataTask = nil
                }
                
                if let error = error{
                    print(error)
                    completion(nil,genericError)
                } else if let data = data {
                    print("\(String(decoding: data , as: UTF8.self))")
                    do{
                        let value = try self?.newJSONDecoder().decode(T.self, from: data)
                        completion(value, nil)
                    }
                    catch{
                        do{
                            let _ = try self?.newJSONDecoder().decode(AuthError.self, from: data)
                            completion(nil, ILPDFError(message: "generic_error".localized, status: 401))
                        } catch{
                            completion(nil, genericError)
                        }
                    }
                } else {
                    completion(nil,genericError)
                }
            }
            dataTask?.resume()
        }
    }
}
/*
 Methods used for coding and decoding Codable data
 */
extension BaseWorker{
    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }

    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
}

/*
 Methods used for uploading file to server
 */
extension BaseWorker{
    /*
     We can generate any boundary we want
     */
    func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    func createBody(with parameters: [String: Any]?, filePathKey: String, urls: [URL], boundary: String) throws -> Data {
        var body = Data()

        parameters?.forEach { (key, value) in
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }

        for url in urls {
            let filename = url.lastPathComponent
            let data = try Data(contentsOf: url)
            let mimetype = mimeType(for: filename)

            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(mimetype)\r\n\r\n")
            body.append(data)
            body.append("\r\n")
        }

        body.append("--\(boundary)--\r\n")
        return body
    }
    
    private func mimeType(for path: String) -> String {
        let pathExtension = URL(fileURLWithPath: path).pathExtension as NSString

        guard
            let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension, nil)?.takeRetainedValue(),
            let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue()
        else {
            return "application/octet-stream"
        }

        return mimetype as String
    }
}
