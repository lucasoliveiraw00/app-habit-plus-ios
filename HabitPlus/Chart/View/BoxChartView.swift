//
//  BoxChartView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 23/11/24.
//

import SwiftUI
import Charts

struct BoxChartView: UIViewRepresentable {
    typealias UIViewType = LineChartView
    
    @Binding var entries: [ChartDataEntry]
    @Binding var dates: [String]
    
    func makeUIView(context: Context) -> LineChartView {
        let uiView = LineChartView()
        
        uiView.legend.enabled = false
        uiView.chartDescription.enabled = false
        
        uiView.xAxis.granularity = 1
        uiView.xAxis.labelPosition = .bottom
        uiView.xAxis.valueFormatter = DateAxisValueFormatter(dates: dates)
        uiView.rightAxis.enabled = false
        uiView.leftAxis.axisLineColor = .orange
        
        uiView.animate(yAxisDuration: 1.0)
        
        uiView.data = addData()
        
        return uiView
    }
    
    private func addData() -> LineChartData {
        
        let colors = [UIColor.white.cgColor, UIColor.orange.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        
        guard let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: colors as CFArray,
            locations: colorLocations
        ) else {
            let emptyDataSet = LineChartDataSet(entries: [], label: "")
            return LineChartData(dataSet: emptyDataSet)
        }
        
        
        let dataSet = LineChartDataSet(entries: entries, label: "My Data")
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.circleRadius = 4
        dataSet.setColor(.orange)
        dataSet.circleColors = [.red]
        dataSet.valueColors = [.red]
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        
        
        let gradientFill = LinearGradientFill(gradient: gradient, angle: 90.0)
        dataSet.fill = gradientFill
        dataSet.drawFilledEnabled = true
        
        return LineChartData(dataSet: dataSet)
    }
    
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        
    }
}

class DateAxisValueFormatter: AxisValueFormatter {
    private let dates: [String]
    
    init(dates: [String]) {
        self.dates = dates
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let position = Int(value)
        
        guard position >= 0 && position < dates.count else {
            return ""
        }
        
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        guard let date = df.date(from: dates[position]) else {
            return ""
        }
        
        df.dateFormat = "dd/MM"
        
        return df.string(from: date)
    }
}


#Preview {
    BoxChartView(entries: .constant([
        ChartDataEntry(x: 1.0, y: 2.0),
        ChartDataEntry(x: 2.0, y: 4.0),
        ChartDataEntry(x: 3.0, y: 6.0)
    ]), dates: .constant([
        "2021-01-01",
        "2021-01-02",
        "2021-01-03",
    ]))
    .frame(maxWidth: .infinity, maxHeight: 350)
}
