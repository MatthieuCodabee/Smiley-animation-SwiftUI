//
//  ContentView.swift
//  MyAnimation
//
//  Created by matthieu passerel on 31/01/2023.
//

import SwiftUI

struct EmojiView: View, Identifiable {
    var id = UUID()
    var name: String
    var x: CGFloat
    var y: CGFloat
    
    var body: some View {
        Text(name)
            .font(.system(size: 45))
            .offset(x: x, y: y)
            .animation(.easeInOut(duration: 0.5), value: x)
    }
}

struct ContentView: View {
    var emojis: [String] = ["🤣", "🤪", "😱", "🥸", "🥰", "🤩"]
    @State var viewArray: [EmojiView] = []
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ZStack {
                ForEach(viewArray) { view in
                    view
                }
            }.onAppear() {
                Timer.scheduledTimer(
                    withTimeInterval: 0.3,
                    repeats: true) { time in
                        let newEmoji = EmojiView(
                            name: emojis[Int.random(in: 0..<emojis.count)],
                            x: CGFloat.random(in: 0..<size.width),
                            y: -200)
                        viewArray.insert(newEmoji, at: 0)
                        for index in 0..<viewArray.count {
                            viewArray[index].y += 60
                            viewArray[index].x += CGFloat.random(in: -60 ... +60)
                            if viewArray[index].y > size.height {
                                viewArray.remove(at: index)
                            }
                        }
                    }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
