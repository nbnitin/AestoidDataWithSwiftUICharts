//
//  ChartView.swift
//  Asteroid
//
//  Created by Nitin Bhatia on 09/02/23.
//

import Charts
import SwiftUI
import Combine

struct ChartView : View {
    @ObservedObject var model: ChartData
    
    var body: some View {
        Chart {
            ForEach(model.chartData) { chartData in
                BarMark(
                    x: .value("Date", chartData.type),
                    y: .value("Total Count",chartData.count)
                )
                .foregroundStyle(.red)
            }
            
            
        }
        
        
    }
}

class ChartData: ObservableObject {
    @Published var chartData = [AestroidData]()
    
    init(chartData : [AestroidData]) {
        self.chartData = chartData
    }
}

struct AestroidData: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}
