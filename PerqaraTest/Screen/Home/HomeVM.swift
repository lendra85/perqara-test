//
//  HomeVM.swift
//  PerqaraTest
//
//  Created by Sailendra Salsabil on 17/08/23.
//

import UIKit

class HomeVM: NSObject {
    let LIMIT = 10
    var gamesResponse: (([Game]) -> ())?
    var page = 1
    var searchKeyword: String = ""
    var games: [Game] = []
    
    func fetchData() {
        var params: [String: String] = [:]
        params["page"] = String(page)
        params["page_size"] = String(LIMIT)
        if !searchKeyword.isEmpty {
            params["search"] = searchKeyword
        }
        ApiService<GameResult>.hit("games", parameters: params) { [weak self] response in
            if let games = response.results {
                self?.gamesResponse?(games)
            }
        }
    }
}
