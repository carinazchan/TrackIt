//
//  Dashboard_UnitTests.swift
//  Prototype V2
//
//  Created by Zuleyka Urieta on 4/4/24.
//

import Foundation

import XCTest
@testable import Prototype_V2

class DashboardTests: XCTestCase {

    func testAngleCalculation() {
        // Given
        let dataPoints: [PieChartDataPoint] = [
            PieChartDataPoint(value: 50, color: .red),
            PieChartDataPoint(value: 30, color: .blue),
            PieChartDataPoint(value: 20, color: .green)
        ]
        
        let pieChartView = PieChartView(dataPoints: dataPoints)
        
        // When
        let angle1 = pieChartView.angle(for: 0, in: dataPoints, total: pieChartView.totalValue(of: dataPoints))
        let angle2 = pieChartView.angle(for: 1, in: dataPoints, total: pieChartView.totalValue(of: dataPoints))
        let angle3 = pieChartView.angle(for: 2, in: dataPoints, total: pieChartView.totalValue(of: dataPoints))
        
        // Then
        XCTAssertEqual(angle1, 0)
        XCTAssertEqual(angle2, 120)
        XCTAssertEqual(angle3, 240)
    }

    func testTotalValueCalculation() {
        // Given
        let dataPoints: [PieChartDataPoint] = [
            PieChartDataPoint(value: 50, color: .red),
            PieChartDataPoint(value: 30, color: .blue),
            PieChartDataPoint(value: 20, color: .green)
        ]
        
        // When
        let totalValue = PieChartView().totalValue(of: dataPoints)
        
        // Then
        XCTAssertEqual(totalValue, 100)
    }
}
