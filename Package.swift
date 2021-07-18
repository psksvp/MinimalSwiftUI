// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MinimalSwiftUI",
    platforms: [ .macOS(.v11)],
    products: [ .library(name: "MinimalSwiftUI",
                       targets: ["MinimalSwiftUI"]), 
				.executable(name: "Example",
				       targets: ["Example"])],
    dependencies: [],
	
    targets: [.target(name: "MinimalSwiftUI",
              dependencies: []),
			  
			  .target(name: "Example",
			  dependencies: ["MinimalSwiftUI"]),
			  
              .testTarget(name: "MinimalSwiftUITests",
                  dependencies: ["MinimalSwiftUI"]),
    ]
)
