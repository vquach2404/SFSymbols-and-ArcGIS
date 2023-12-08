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

struct ContentView: View {
    // Displays a map.
    @State private var map: Map = {
        // Creates a map with the topographic basemap style.
        let map = Map(basemapStyle: .arcGISTopographic)
        // Sets the initial viewpoint to Malibu, Callifornia.
        map.initialViewpoint = Viewpoint(latitude: 34.02700, longitude: -118.80500, scale: 72_000)
        // The feature service URL containing trailhead data.
        let featureServiceURL = URL(string: "https://services3.arcgis.com/GVgbJbqm8hXASVYi/arcgis/rest/services/Trailheads/FeatureServer/0")!
        // Creates a service feature table with the URL.
        let serviceFeatureTable = ServiceFeatureTable(url: featureServiceURL)
        // Creates a feature layer from the feature table.
        let featureLayer = FeatureLayer(featureTable: serviceFeatureTable)
        // Creates a symbol configuration to apply to the image.
        var config = UIImage.SymbolConfiguration(paletteColors: [.systemPurple, .systemCyan])
        // Applies a size to the image.
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30.0)))
        // Creates an image from an SF Symbol.
        let image = UIImage(systemName: "figure.walk.circle.fill", withConfiguration: config)!
        // Creates a picture marker symbol from the image.
        let symbol = PictureMarkerSymbol(image: image)
        // Creates a renderer using the symbol and adds it to the feature layer.
        featureLayer.renderer = SimpleRenderer(symbol: symbol)
        // Adds the feature layer to the map.
        map.addOperationalLayer(featureLayer)
        
        return map
    }()
    
    var body: some View {
        // Adds the map to the map view.
        MapView(map: map)
        
    }
}
