//
//  FavoriteMoviesWidgetLiveActivity.swift
//  FavoriteMoviesWidget
//
//  Created by Matheus Vicente on 13/06/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct FavoriteMoviesWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct FavoriteMoviesWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FavoriteMoviesWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension FavoriteMoviesWidgetAttributes {
    fileprivate static var preview: FavoriteMoviesWidgetAttributes {
        FavoriteMoviesWidgetAttributes(name: "World")
    }
}

extension FavoriteMoviesWidgetAttributes.ContentState {
    fileprivate static var smiley: FavoriteMoviesWidgetAttributes.ContentState {
        FavoriteMoviesWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: FavoriteMoviesWidgetAttributes.ContentState {
         FavoriteMoviesWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: FavoriteMoviesWidgetAttributes.preview) {
   FavoriteMoviesWidgetLiveActivity()
} contentStates: {
    FavoriteMoviesWidgetAttributes.ContentState.smiley
    FavoriteMoviesWidgetAttributes.ContentState.starEyes
}
