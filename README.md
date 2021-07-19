# MinimalSwiftUI

This package allowed building SwiftUI application without using Xcode. The entry point for an application can be done like below. 

~~~swift 

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


~~~

Credit : https://gist.github.com/chriseidhof/26768f0b63fa3cdf8b46821e099df5ff
