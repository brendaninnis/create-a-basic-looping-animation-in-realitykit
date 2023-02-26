//
//  ResourceLoader.swift
//  Spinny Bagels
//
//  Created by Brendan Innis on 2023-01-19.
//

import Foundation
import Combine
import RealityKit

class ResourceLoader {
    typealias LoadCompletion = (Result<BagelEntity, Error>) -> Void
    
    private var loadCancellable: AnyCancellable?
    private var bagelEntity: BagelEntity?
    
    func loadResources(completion: @escaping LoadCompletion) -> AnyCancellable? {
        guard let bagelEntity else {
            loadCancellable = BagelEntity.loadAsync.sink { result in
                if case let .failure(error) = result {
                    print("Failed to load BagelEntity: \(error)")
                    completion(.failure(error))
                }
            } receiveValue: { [weak self] bagelEntity in
                guard let self else {
                    return
                }
                self.bagelEntity = bagelEntity
                completion(.success(bagelEntity))
            }
            return loadCancellable
        }
        completion(.success(bagelEntity))
        return loadCancellable
    }
        
    func createCup() throws -> Entity {
        guard let cup = bagelEntity?.model else {
            throw ResourceLoaderError.resourceNotLoaded
        }
        return cup.clone(recursive: true)
    }
}

enum ResourceLoaderError: Error {
    case resourceNotLoaded
}
