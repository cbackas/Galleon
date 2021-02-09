// Created for Galleon in 2021
// Using Swift 5.0

import Foundation
import Alamofire
import SwiftyJSON

extension SonarrComm {
    public func getCalendar(startDate: Date, endDate: Date, completion: @escaping (_ entries: [SonarrCalendarEntry]?, _ errorDescription: String?) -> Void) {
        let storedURL = SonarrComm.shared.getServerURLFromStorage() ?? ""
        let apiKey = SonarrComm.shared.getAPIKeyFromStorage() ?? ""
        let endpoint = "calendar"
        
        guard let url = SonarrComm.shared.createStandardUrl(serverUrl: storedURL, endpoint: endpoint) else {
            completion(nil, "Invalid server url")
            return
        }
        
        let method = HTTPMethod(rawValue: "GET")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var params: [String: Any] = [:]
        params["apikey"] = apiKey
        params["start"] = dateFormatter.string(from: startDate)
        params["end"] = dateFormatter.string(from: endDate)
        
        SonarrComm.shared.sessionManager.request(url, method: method, parameters: params, encoding: URLEncoding.default, interceptor: nil).validate(statusCode: 200..<300).responseJSON { (response) in
//            debugPrint(response)
            
            switch response.result {
            case .failure(let error):
                completion(nil, error.errorDescription)
            case .success( _):
                if let data = response.data {
                    if let jsonResponse = String(data: data, encoding: String.Encoding.utf8) {
                        let decoder = JSONDecoder()
                        do {
                            let object = try decoder.decode([SonarrCalendarEntry].self, from: Data(jsonResponse.utf8))
                            completion(object, nil)
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
