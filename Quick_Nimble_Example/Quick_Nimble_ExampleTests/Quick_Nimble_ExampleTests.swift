//
//  Quick_Nimble_ExampleTests.swift
//  Quick_Nimble_ExampleTests
//
//  Created by 여정수 on 2021/10/29.
//

import Quick
import Nimble
@testable import Quick_Nimble_Example

// QuickSpec: XCTestCase
class Quick_Nimble_ExampleTests: QuickSpec {
    override func spec() {
        var viewController: MoviesTableViewController!

        // Given
        describe("MoviesTableViewControllerSpec") {
            beforeEach {
                print("beforeEach called")

                viewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviesTableViewController") as! MoviesTableViewController)

                _ = viewController.view
            }

            // When
            context("when view is loaded") {
                // Then
                it("should have 8 movies loaded") {
                    expect(viewController.tableView.numberOfRows(inSection: 0)).to(equal(8))
                }
            }

            // When
            context("TableView") {
                var cell: UITableViewCell!

                beforeEach {
                    cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                }

                it("should show movie title and genre") {
                    expect(cell.textLabel?.text).to(equal("The Emoji Movie"))
                    expect(cell.detailTextLabel?.text).to(equal("Animation"))
                }
            }
        }
    }
}

