//
//  InteractiveMapUnitTests.swift
//  Prototype V2Tests
//
//  Created by Dylan Calderon on 4/3/24.
//

import XCTest
import MapKit
import SwiftUI
@testable import Prototype_V2

class MapViewTests: XCTestCase {
    
    // Test if the MapView initializes correctly
    func testMapViewInitialization() {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        let selectedAnnotation = MyAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), title: "Test", subtitle: "Test", onAnnotationSelected: nil)
        let mapView = MapView(region: .constant(region), selectedAnnotation: .constant(selectedAnnotation))
        XCTAssertNotNil(mapView)
    }
    
    // Test if annotations are added correctly
    func testAnnotationsAdded() {
        // Mock coordinate data
        let coordinates: [CLLocationCoordinate2D] = [
            CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        ]
        
        // Create mock annotations
        var annotations = [MyAnnotation]()
        for coordinate in coordinates {
            let annotation = MyAnnotation(
                coordinate: coordinate,
                title: "Test",
                subtitle: "Test",
                onAnnotationSelected: nil
            )
            annotations.append(annotation)
        }
        
        // Create a mock MapView with MKMapView instance
        let mapView = MapView(region: .constant(MKCoordinateRegion()), selectedAnnotation: .constant(nil), mapView: MKMapView())
        for annotation in annotations {
            mapView.mapView.addAnnotation(annotation)
        }
        
        // Verify annotations count
        XCTAssertEqual(mapView.annotations?.count, annotations.count)
    }
}


// MockMapView class to simulate MKMapView behavior
class MockMapView: MKMapView {
    var addedAnnotations = [MKAnnotation]()

    override func addAnnotation(_ annotation: MKAnnotation) {
        super.addAnnotation(annotation)
        addedAnnotations.append(annotation)
    }
}
