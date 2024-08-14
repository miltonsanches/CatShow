//
//  DetailInteractor.swift
//  CatShow
//
//  Created by Milton Leslie Sanches on 12/08/24.
//

import Foundation

protocol DetailInteractorInput {
    func fetchCatDetails()
}

class DetailInteractor: DetailInteractorInput {
    weak var presenter: DetailPresenterOutput?

    func fetchCatDetails() {
        // Implemente a lógica para buscar detalhes
        // Quando os detalhes forem buscados, você pode chamar:
        // presenter?.didFetchCatDetails(item)
    }
}
