// Created for Galleon in 2021
// Using Swift 5.0

import Foundation
import Alamofire
import SwiftyJSON

public class SonarrComm: SessionDelegate {
    public static let shared: SonarrComm = {
        let instance = SonarrComm()
        return instance
    }()
    
    
    internal lazy var sessionManager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.af.default
        return Alamofire.Session(configuration: configuration, delegate: self, rootQueue: DispatchQueue(label: "com.cback.sessionManagerData.rootQueue"), startRequestsImmediately: true, requestQueue: nil, serializationQueue: nil, interceptor: nil, serverTrustManager: nil, redirectHandler: nil, cachedResponseHandler: nil, eventMonitors: self.makeEvents())
    }()
    
    private func makeEvents() -> [EventMonitor] {
        let events = ClosureEventMonitor()
        events.requestDidFinish = { request in
            print("Request finished \(request)")
        }
        events.taskDidComplete = { session, task, error in
            print("Request failed \(session) \(task) \(String(describing: error))")
        }
        return [events]
    }
    
    func StringToUrl(_ string: String) -> URLConvertible? {
        var url: URLConvertible
        do {
            try url = string.asURL()
            return url
        } catch _ {
            return nil
        }
    }
    
    func encodeString(_ string: String) -> String? {
        
        let encodeCharacterSet = " #;?@&=$+{}<>,!'*|"
        let allowedCharacterSet = (CharacterSet(charactersIn: encodeCharacterSet).inverted)
        let encodeString = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
        
        return encodeString
    }
    
    func encodeStringToUrl(_ string: String) -> URLConvertible? {
        if let escapedString = encodeString(string) {
            return StringToUrl(escapedString)
        }
        return nil
    }
    
    func createStandardUrl(serverUrl: String, endpoint: String) -> URLConvertible? {
        guard var serverUrl = encodeString(serverUrl) else { return nil }
        if serverUrl.last != "/" { serverUrl = serverUrl + "/" }
        
        serverUrl = serverUrl + "api/" + endpoint
        
        return StringToUrl(serverUrl)
    }
    
    public func getServerStatus(completion: @escaping (_ status: SonarrStatus?, _ errorDescription: String?) -> Void) {
        let storedURL = SonarrComm.shared.getServerURLFromStorage() ?? ""
        let apiKey = SonarrComm.shared.getAPIKeyFromStorage() ?? ""
        let endpoint = "system/status"
        
        guard let url = SonarrComm.shared.createStandardUrl(serverUrl: storedURL, endpoint: endpoint) else {
            completion(nil, "Invalid server url")
            return
        }
        
        let method = HTTPMethod(rawValue: "GET")
        
        var params: [String: Any] = [:]
        params["apikey"] = apiKey
        
        SonarrComm.shared.sessionManager.request(url, method: method, parameters: params, encoding: URLEncoding.default, interceptor: nil).validate(statusCode: 200..<300).responseJSON { (response) in
            debugPrint(response)
            
            switch response.result {
            case .failure(let error):
                completion(nil, error.errorDescription)
            case .success( _):
                if let data = response.data {
                    if let jsonResponse = String(data: data, encoding: String.Encoding.utf8) {
                        let decoder = JSONDecoder()
                        do {
                            let serverStatus = try decoder.decode(SonarrStatus.self, from: Data(jsonResponse.utf8))
                            completion(serverStatus, nil)
                        } catch {
                            print(error)
                            completion(nil, "Error converting json to struct")
                        }
                    }
                } else {
                    completion(nil, "No data")
                }
            }
        }
    }
}
