//
//  DetailPresenter.swift
//  CatShow
//
//  Created by Milton Leslie Sanches on 12/08/24.
//

import Foundation

// Declaração do protocolo DetailPresenterOutput
protocol DetailPresenterOutput: AnyObject {
    func didFetchCatDetails(_ item: CatItem)
}

// Protocolo DetailPresenterInput já existente
protocol DetailPresenterInput {
    func viewDidLoad()
}

// Implementação do DetailPresenter
class DetailPresenter: DetailPresenterInput {
    weak var view: DetailView?
    var interactor: DetailInteractorInput?
    var router: DetailRouterInput?
    var catItem: CatItem?

    func viewDidLoad() {
        if let item = catItem {
            view?.displayCatDetails(for: item)
        } else {
            interactor?.fetchCatDetails()
        }
    }
}

extension DetailPresenter: DetailPresenterOutput {
    func didFetchCatDetails(_ item: CatItem) {
        self.catItem = item
        view?.displayCatDetails(for: item)
    }
}
