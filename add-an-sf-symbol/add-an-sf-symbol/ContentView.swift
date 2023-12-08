// Copyright 2023 Esri
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import SwiftUI
import ArcGIS

private class Model: ObservableObject {
    // Creates a graphics overlay.
    let graphicsOverlay = GraphicsOverlay()
    
    init() {
        // Creates a symbol configuration to apply to the image.
        var config = UIImage.SymbolConfiguration(paletteColors: [.systemPurple, .systemCyan])
        // Applies a size to the image.
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30.0)))
        // Creates a UIImage from an SFSymbol.
        let image = UIImage(systemName: "figure.walk.circle.fill", withConfiguration: config)!
        // Creates a picture marker symbol from the image.
        let symbol = PictureMarkerSymbol(image: image)
        // Creates a point for the graphic's location.
        let point = Point(x: -118.806546, y: 34.020933, spatialReference: .wgs84)
        // Creates a graphic with the point and symbol.
        let graphic = Graphic(geometry: point, symbol: symbol)
        // Adds the graphic to the graphics overlay.
        graphicsOverlay.addGraphic(graphic)
        
    }
}

struct ContentView: View {
    @State private var map: Map = {
        // Creates a map with the topographic basemap style.
        let map = Map(basemapStyle: .arcGISTopographic)
        // Creates the initial viewpoint in Malibu, California.
        map.initialViewpoint = Viewpoint(latitude: 34.02700, longitude: -118.80500, scale: 72_000)
        return map
    }()
    
    @StateObject private var model = Model()
    
    var body: some View {
        VStack {
            // Adds the map and graphics overlay to the map view.
            MapView(map: map, graphicsOverlays: [model.graphicsOverlay])
        }
    }
}
