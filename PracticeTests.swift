//
//  PracticeTests.swift
//  PracticeTests
//
//  Created by Zuleyka Urieta & Carina Chan on 3/13/24.
// --> via pair programming
//

import XCTest
@testable import Practice

final class PracticeTests: XCTestCase {

    var pieChartView: PieChartView!
    var dataPoints: [PieChartDataPoint]!

    override func setUpWithError() throws {
        // Initialize PieChartView and dataPoints before each test
        dataPoints = [
            PieChartDataPoint(value: 100, color: .red),
            PieChartDataPoint(value: 200, color: .green),
            PieChartDataPoint(value: 300, color: .blue)
        ]
        pieChartView = PieChartView(dataPoints: dataPoints)
    }

    override func tearDownWithError() throws {
        // Clean up any resources after each test
        pieChartView = nil
        dataPoints = nil
    }

    func testSliceAnglesSum() throws {
        // Ensure that the sum of the angles of all slices equals 360 degrees
        let totalAngle = pieChartView.dataPoints.reduce(0) { $0 + $1.value / pieChartView.totalValue(of: pieChartView.dataPoints) * 360 }
        XCTAssertEqual(totalAngle, 360, accuracy: 0.01, "Sum of slice angles should be equal to 360 degrees")
    }

    func testTotalValueCalculation() throws {
        // Ensure that the total value of data points is correctly calculated
        XCTAssertEqual(pieChartView.totalValue(of: dataPoints), 1500, "Total value calculation should be accurate")
    }

}
