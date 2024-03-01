import SwiftUI
import MapKit

class MyAnnotation: NSObject, Identifiable, MKAnnotation {
    var id = UUID()
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var onAnnotationSelected: (() -> Void)?

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, onAnnotationSelected: (() -> Void)? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.onAnnotationSelected = onAnnotationSelected
    }
}

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.7879, longitude: -117.8531),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Adjust the span for a more zoomed-out view
    )

    @State private var selectedAnnotation: MyAnnotation?

    var body: some View {
        NavigationView {
            VStack {
                MapView(region: $region, selectedAnnotation: $selectedAnnotation)

                // Display popup when an annotation is selected
                if let annotation = selectedAnnotation {
                    PopupView(title: annotation.title ?? "", subtitle: annotation.subtitle ?? "") {
                        // Trigger zooming behavior
                        withAnimation {
                            region.center = annotation.coordinate
                            region.span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                        }
                    }
                }

                Button(action: {
                    // Reset to the original view and clear the selectedAnnotation
                    withAnimation {
                        region = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 33.7879, longitude: -117.8531),
                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                        )
                        selectedAnnotation = nil
                    }
                }, label: {
                    Text("Reset")
                        .frame(width: 250, height: 50, alignment: .center)
                        .background(Color.red)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                })
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Text(""), trailing: Text("")) // To align the title in the center
            .navigationTitle("Interactive Map")
        }
    }
}

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var selectedAnnotation: MyAnnotation?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        // Geocode the addresses and add the annotations
        let addresses = [
            "393 N Glassell St, Orange, CA 92866",
            "2620 E Chapman Ave, Orange, CA 92869"
        ]

        for address in addresses {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address) { (placemarks, error) in
                if let placemark = placemarks?.first, let location = placemark.location {
                    let coordinate = location.coordinate

                    var title = ""
                    var subtitle = ""
                    if address.contains("393 N Glassell St") {
                        title = "Starbucks"
                        subtitle = "Starbucks on 393 N Glassell St, Orange, CA 92866.\nTotal Spent this Month: $400"
                    } else if address.contains("2620 E Chapman Ave") {
                        title = "Target"
                        subtitle = "Target on 2620 E Chapman Ave, Orange, CA 92869.\nTotal Spent this Month: $1000"
                    }

                    let annotation = MyAnnotation(
                        coordinate: coordinate,
                        title: title,
                        subtitle: subtitle,
                        onAnnotationSelected: {
                            // Handle tap on annotation
                            withAnimation {
                                context.coordinator.parent?.region.center = coordinate
                                context.coordinator.parent?.region.span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                            }
                        }
                    )
                    mapView.addAnnotation(annotation)
                }
            }
        }

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView?

        init(parent: MapView) {
            self.parent = parent
        }

        // Handle selecting an annotation
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation as? MyAnnotation {
                parent?.selectedAnnotation = annotation
                annotation.onAnnotationSelected?()
            }
        }
    }
}

struct PopupView: View {
    var title: String
    var subtitle: String
    var onTapAction: (() -> Void)?

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)

            Text(subtitle)
                .foregroundColor(.gray) // Make it darker
                .multilineTextAlignment(.center) // Center the text
                .onTapGesture {
                    onTapAction?()
                }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
