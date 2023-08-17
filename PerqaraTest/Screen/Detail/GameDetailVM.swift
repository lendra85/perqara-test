//
//  GameDetailVM.swift
//  PerqaraTest
//
//  Created by Sailendra Salsabil on 17/08/23.
//

import UIKit

class GameDetailVM: NSObject {
    var detailResponse: ((GameDetail) -> ())?
    var game: GameDetail?
    
    func loadData(_ id: Int) {
        ApiService<GameDetail>.hit("games/\(id)", parameters: [:]) { [weak self] response in
            self?.game = response
            self?.detailResponse?(response)
        }
    }
    
    func save() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
    }
}
