//
//  ListPresenter.swift
//  CatShow
//
//  Created by Milton Leslie Sanches on 12/08/24.
//

import Foundation

protocol ListPresenterInput {
    func viewDidLoad()
    func numberOfItems() -> Int
    func item(at index: Int) -> CatItem?
    func didSelectItem(at index: Int)
}

class ListPresenter: ListPresenterInput {
    weak var view: ListView?
    var interactor: ListInteractorInput?
    var router: ListRouterInput?

    private var catItems: [CatItem] = []

    func viewDidLoad() {
        interactor?.fetchCatItems()
    }

    func numberOfItems() -> Int {
        return catItems.count
    }

    func item(at index: Int) -> CatItem? {
        guard index < catItems.count else { return nil }
        return catItems[index]
    }

    func didSelectItem(at index: Int) {
        guard index < catItems.count else { return }
        let selectedCatItem = catItems[index]
        router?.navigateToDetail(with: selectedCatItem)
    }
}

extension ListPresenter: ListInteractorOutput {
    func didFetchCatItems(_ items: [CatItem]) {
        catItems = items
        
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadData()
        }
    }

    func didFailFetchingCatItems(with error: Error) {
        // Handle error (e.g., show an alert)
        print("Error fetching cat items: \(error.localizedDescription)")
    }
}
