//
//  CupEntity.swift
//  Spinny Bagels
//
//  Created by Brendan Innis on 2023-01-19.
//

import Foundation
import Combine
import RealityKit

final class BagelEntity: Entity {
    var model: Entity?
    
    static var loadAsync: AnyPublisher<BagelEntity, Error> {
        return Entity.loadAsync(named: "bagel")
            .map { loadedBagel -> BagelEntity in
                let bagel = BagelEntity()
                loadedBagel.name = "Bagel"
                bagel.model = loadedBagel
                return bagel
            }
            .eraseToAnyPublisher()
    }
}
