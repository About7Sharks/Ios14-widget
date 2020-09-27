//
//  WidgetView.swift
//  scale
//
//  Created by Zachary Carlin on 9/26/20.
//

import SwiftUI
import WidgetKit

struct WidgetData{
    let weight: Measurement<UnitMass>
    let date: Date
}

extension WidgetData{
    static let previewData = WidgetData(weight: Measurement<UnitMass>(value: 193.6, unit: .pounds), date: Date().advanced(by: (-60*29)))
}

struct WidgetView: View {
    let data: WidgetData
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        ZStack{
            Color(.orange)
            HStack{
                VStack(alignment: .leading) {
                    WeightView(data: data)
                    Spacer()
                    LastUpdatedView(data: data)
                }
                .padding(.all)
                if widgetFamily == .systemMedium{
                    Image("weight").resizable()
                }
            }
        }
        
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            WidgetView(data: .previewData).previewContext(WidgetPreviewContext(family: .systemSmall))
// previews for large and medium views
//            WidgetView(data: .previewData).previewContext(WidgetPreviewContext(family: .systemMedium))
//            WidgetView(data: .previewData).previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}



struct WeightView: View {
    var data: WidgetData
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Weight")
                    .font(.body)
                    .foregroundColor(.black)
                    .bold()
                Spacer()
                Text(measurementFormatter.string(from: data.weight))
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
                    .minimumScaleFactor(0.7)
            }
            
            Spacer()
        }
        .padding(.all, 8)
        .background(ContainerRelativeShape().fill(Color(.white)))
        .border(Color.black,width: 3)
    }
}

extension WeightView{
    var measurementFormatter : MeasurementFormatter {
        let mf = MeasurementFormatter()
        mf.locale = Locale(identifier: "en_US")
        return mf
    }
}

struct LastUpdatedView: View {
    let data: WidgetData
    var body: some View {
        VStack(alignment: .leading){
            Text("Last Updated")
                .font(.body)
                .bold()
                .foregroundColor(.black)
            Text("\(data.date, style: .relative)")
                .font(.caption)
                .foregroundColor(.black)
                .minimumScaleFactor(0.7)
                .redacted(reason: .placeholder)
        }
    }
}
