import Foundation
import SwiftUI
import MinimalSwiftUI

// Entry point
NSApplication.shared.run
{
  ContentView().frame(maxWidth: .infinity, maxHeight: .infinity)
}


// root view
struct ContentView: View
{
  var body: some View
  {
    Text("Hello, world!").padding()
  }
}
