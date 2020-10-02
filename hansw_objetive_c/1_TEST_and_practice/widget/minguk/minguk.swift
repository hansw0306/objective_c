//
//  minguk.swift
//  minguk
//
//  Created by SANGWON HAN on 2020/09/23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct mingukEntryView : View {
    var entry: Provider.Entry
    let image = UIImage(named: "minmin")
    
    var body: some View {
        //Text(entry.date, style: .time).font(.system(size: 28))
        Image(uiImage: image!)
            .resizable()
    }
}

@main
struct minguk: Widget {
    let kind: String = "민국이가 응원합니다."
        
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: ConfigurationIntent.self,
                            provider: Provider())
        { entry in mingukEntryView(entry: entry)
            
        }
        .configurationDisplayName("민국이를 화면에 넣어보세요")
        .description("민국이가 당신을 지켜봐 드립니다.")
    }
}

struct minguk_Previews: PreviewProvider {
    static var previews: some View {
        mingukEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
