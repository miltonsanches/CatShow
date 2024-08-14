//
//  ListRouter.swift
//  CatShow
//
//  Created by Milton Leslie Sanches on 12/08/24.
//

import UIKit

protocol ListRouterInput {
    func navigateToDetail(with item: CatItem)
}

class ListRouter: ListRouterInput {
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = ListViewController()
        let presenter = ListPresenter()
        let interactor = ListInteractor()
        let router = ListRouter()

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.presenter = presenter

        router.viewController = view

        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }

    func navigateToDetail(with item: CatItem) {
        let detailViewController = DetailRouter.createModule(with: item)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
