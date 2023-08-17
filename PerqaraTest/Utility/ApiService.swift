//
//  ApiService.swift
//  PerqaraTest
//
//  Created by Sailendra Salsabil on 15/08/23.
//

import Foundation

let BASE_URL = "https://api.rawg.io/api/"
let API_KEY = "44992eac45bd4115a015b095b736d798"

class ApiService<T: Codable> {
    internal static func hit(_ path: String, parameters: [String: String], completion: @escaping ((T) -> Void)) {
        let urlString: String = BASE_URL + path
        var params = parameters
        params["key"] = API_KEY
        var components = URLComponents(string: urlString)!
        components.queryItems = params.map {
             URLQueryItem(name: $0, value: $1)
        }
        let url = components.url!
        printIfDebug("URL: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let responseString = String(decoding: data, as: UTF8.self)
                printIfDebug("response: \(responseString)")
                do {
                    let responseObject = try jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject)
                    }
                } catch let jsonError {
                    printIfDebug("json error: \(jsonError)")
                }
            }
            printIfDebug("URL response \(String(describing: urlResponse))")
            printIfDebug("Error: \(String(describing: error))")
        }.resume()
    }
}
