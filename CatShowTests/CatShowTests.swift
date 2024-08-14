//
//  CatShowTests.swift
//  CatShowTests
//
//  Created by Milton Leslie Sanches on 12/08/24.
//

import XCTest
@testable import CatShow

final class CatShowTests: XCTestCase {

    override func setUpWithError() throws {
        // Código de configuração para cada teste
    }

    override func tearDownWithError() throws {
        // Código de limpeza após cada teste
    }

    func testCatItemDecoding() throws {
        let jsonData = """
        [
            {
                "_id": "FAkFJCfYbZOF8aDI",
                "mimetype": "image/jpeg",
                "size": 9612,
                "tags": [
                    "cute",
                    "white",
                    "funny"
                ]
            }
        ]
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let catItems = try decoder.decode([CatItem].self, from: jsonData)
        
        XCTAssertEqual(catItems.count, 1)
        XCTAssertEqual(catItems[0].id, "FAkFJCfYbZOF8aDI")
        XCTAssertEqual(catItems[0].mimetype, "image/jpeg")
        XCTAssertEqual(catItems[0].size, 9612)
        XCTAssertEqual(catItems[0].tags, ["cute", "white", "funny"])
    }

    func testAPIIntegration() throws {
        let expectation = self.expectation(description: "API call completes")
        
        let url = URL(string: "https://cataas.com/api/cats?tags=cute")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNil(error, "API call failed: \(error!.localizedDescription)")
            XCTAssertNotNil(data, "No data was returned")
            XCTAssertTrue((response as! HTTPURLResponse).statusCode == 200, "Response code is not 200")
            expectation.fulfill()
        }
        task.resume()
        
        wait(for: [expectation], timeout: 10)
    }

    func testPerformanceExample() throws {
        self.measure {
            // Medir o tempo de alguma operação importante aqui
        }
    }
}

