import SwiftUI
import MapKit
import SwiftData

struct DestinationLocationsMapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    
    var destination: Destination
    
    var body: some View {
        @Bindable var destination = destination
        VStack {
            LabeledContent {
                TextField("Enter destination name", text: $destination.name)
                    .textFieldStyle(.roundedBorder)
                    .foregroundStyle(.primary)
            }label: {
                Text("Name")
            }
            
            HStack {
                Text("Adjust the map to set the region for your destination")
                    .foregroundStyle(.secondary)
                Spacer()
                Button("Set region") {
                    if let visibleRegion {
                        destination.latitude = visibleRegion.center.latitude
                        destination.longitude = visibleRegion.center.longitude
                        destination.latitudeDelta = visibleRegion.span.latitudeDelta
                        destination.longitudeDelta = visibleRegion.span.longitudeDelta
                    }
                }
                .buttonStyle(.borderedProminent)
                
            }
        }
        .padding(.horizontal)
        .padding(.top)
        Map(
            position: $cameraPosition
        ){
            ForEach(destination.placemarks) { placemark in
                Marker( coordinate: placemark.coordinate) {
                    Label(placemark.name, systemImage: "star.fill")
                }
            }
        }
        .navigationTitle(destination.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            
            if let region = destination.region {
                cameraPosition = .region(region)
            }
        }
        .onMapCameraChange(
            frequency: .onEnd
        ) { context in
            visibleRegion = context.region
        }
        
    }
}

#Preview {
    let container = Destination.preview
    let fetchDescriptor = FetchDescriptor<Destination>()
    let destination = try! container.mainContext.fetch(fetchDescriptor)[0]
    
    return NavigationStack {
        DestinationLocationsMapView(destination: destination)
    }
}
