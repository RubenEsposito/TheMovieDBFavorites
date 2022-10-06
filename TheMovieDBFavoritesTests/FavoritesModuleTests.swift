//
//  TheMovieDBFavoritesTests.swift
//  TheMovieDBFavoritesTests
//
//  Created by Ruben Exposito Marin on 5/10/22.
//

import XCTest
@testable import TheMovieDBFavorites
@testable import Alamofire

class FavoriteModuleTests: XCTestCase {

    var presenter: FavoritesPresenter!
    var view: MockFavoritesViewController!
    var interactor: MockFavoritesInteractor!
    var router: MockFavoritesRouter!
    
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
    }
    
    override func tearDown() {
        view = nil
        presenter = nil
        interactor = nil
        router = nil
    }
    
    // MARK: - Test Methods
    func test_viewDidLoad_Invoke_SetUp_Views() {
        presenter.viewDidLoad()
        XCTAssertTrue(view.isCalledSetupTableView)
    }
    
    func test_viewWillAppear_Invoke_SetUp_Views() {
        presenter.viewWillAppear()
        XCTAssertTrue(view.isCalledSetupView)
        XCTAssertTrue(view.isCalledShowLoading)
    }
    
    func test_view_methods_with_no_data() {
        presenter.viewWillAppear()
        XCTAssertTrue(interactor.isFetchFavoriteMoviesCalled)
        presenter.fetchFavoriteMovies(result: [])

        XCTAssertTrue(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)

        XCTAssertEqual(presenter.numberOfItems(), 0)
        XCTAssertEqual(presenter.movie(0)?.id, nil)
    }

    func test_view_methods_with_data() {
        presenter.viewWillAppear()
        XCTAssertTrue(interactor.isFetchFavoriteMoviesCalled)
        presenter.fetchFavoriteMovies(result: createFavoritesResponse())
        
        XCTAssertTrue(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)
        
        XCTAssertEqual(presenter.movie(0)?.id, 1)
        XCTAssertEqual(presenter.numberOfItems(), 1)
    }
    
    // MARK: - Private Methods
    private func createFavoritesResponse() -> [FavoriteMovie] {
        [
            .init(backdrop_path: "Image 1", id: 1, overview: "Desc 1", release_date: "Date 1", title: "Title 1")
        ]
    }
    
}

// MARK: - Mock Classes
final class MockFavoritesViewController: FavoritesViewControllerProtocol {
    
    var isCalledReloadData = false
    var isCalledShowLoading = false
    var isCalledHideLoading = false
    var isCalledSetupCollectionView = false
    var isCalledSetupTableView = false
    var isCalledSetupView = false
    
    func reloadData() {
        isCalledReloadData = true
    }
    
    func showLoadingView() {
        isCalledShowLoading = true
    }
    
    func hideLoadingView() {
        isCalledHideLoading = true
    }
    
    func setupCollectionView() {
        isCalledSetupCollectionView = true
    }
    
    func setupTableView() {
        isCalledSetupTableView = true
    }
    
    func setUpView() {
        isCalledSetupView = true
    }
}

final class MockFavoritesInteractor: FavoritesInteractorProtocol {
    
    var isFetchFavoriteMoviesCalled = false
    
    func fetchFavoriteMovies() {
        isFetchFavoriteMoviesCalled = true
    }
}

final class MockFavoritesRouter: FavoritesRouterProtocol {
    
    var isRouteDetail = false
    
    func navigate(_ route: FavoritesRoutes) {
        switch route {
        case .detail(_):
            isRouteDetail = true
        }
    }
}
