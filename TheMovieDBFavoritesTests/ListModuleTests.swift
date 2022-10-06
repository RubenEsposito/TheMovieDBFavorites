//
//  ListModuleTests.swift
//  TheMovieDBFavoritesTests
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import XCTest
@testable import TheMovieDBFavorites
@testable import Alamofire

class ListModuleTests: XCTestCase {

    var presenter: ListPresenter!
    var view: MockListViewController!
    var interactor: MockListInteractor!
    var router: MockListRouter!
    
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
        XCTAssertTrue(view.isCalledSetupSearchView)
        XCTAssertTrue(view.isCalledShowLoading)
    }
    
    func test_viewWillAppear_Invoke_SetUp_Views() {
        presenter.viewWillAppear()
        XCTAssertTrue(view.isCalledSetupView)
    }
    
    func test_view_methods_with_no_data() {
        presenter.viewDidLoad()
        presenter.fetchPopularMovies(result: .failure(AFError.invalidURL(url: "")))
        
        XCTAssertFalse(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)
        
        XCTAssertEqual(presenter.numberOfItems(), 0)
        XCTAssertEqual(presenter.movie(0)?.id, nil)
    }
    
    func test_viewDidLoad_Invoke_Fetch_Datas_Succes_Status_Empty_Data() {
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.isFetchPopularMoviesCalled)
        
        presenter.fetchPopularMovies(result: .success(.init(page: nil, results: nil, total_pages: nil, total_results: nil)))
        
        XCTAssertFalse(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)
        
        XCTAssertEqual(presenter.movie(0)?.id, nil)
        XCTAssertEqual(presenter.numberOfItems(), 0)
    }
    
    func test_viewDidLoad_Invoke_Fetch_Datas_Succes_Status_Filled_Data() {
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.isFetchPopularMoviesCalled)
        presenter.fetchPopularMovies(result: .success(createListResponse()))
        XCTAssertTrue(view.isCalledReloadData)
        XCTAssertTrue(view.isCalledHideLoading)
        XCTAssertEqual(presenter.movie(0)?.id, 416141)
        XCTAssertEqual(presenter.numberOfItems(), 1)
    }
    
    func test_navigate_search_view_with_search_view_typing() {
        presenter.viewDidLoad()
        presenter.searchMovie(searchText: "Her şey için teşekkürler Kerim Hocam :)")
        XCTAssertTrue(router.isRouteSearch)
    }
    
    // MARK: - Private Methods
    private func createListResponse() -> ListResponse {
        .init(
            page: 0,
            results: [
                .init(
                    adult: false,
                    backdrop_path: "backdrop_path",
                    genre_ids: [6,1],
                    id: 416141,
                    original_language: "original_language",
                    original_title: "original_title",
                    overview: "overview",
                    popularity: 10.0,
                    poster_path: "poster_path",
                    release_date: "release_date",
                    title: "title",
                    video: true,
                    vote_average: 6.1,
                    vote_count: 8
                )
            ],
            total_pages: 3,
            total_results: 5
        )
    }
    
}

// MARK: - Mock Classes
final class MockListViewController: ListViewControllerProtocol {
    
    var isCalledReloadData = false
    var isCalledShowLoading = false
    var isCalledHideLoading = false
    var isCalledSetupSearchView = false
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
    
    func setupSearchView() {
        isCalledSetupSearchView = true
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

final class MockListInteractor: ListInteractorProtocol {
    
    var isFetchPopularMoviesCalled = false
    
    func fetchPopularMovies() {
        isFetchPopularMoviesCalled = true
    }
}

final class MockListRouter: ListRouterProtocol {
    
    var isRouteDetail = false
    var isRouteSearch = false
    
    func navigate(_ route: ListRoutes) {
        switch route {
        case .detail(_):
            isRouteDetail = true
        case .search(_):
            isRouteSearch = true
        }
    }
}
