// swift-tools-version:5.4
import PackageDescription

/// __Nib Core:__ Core types and behaviours for the Nib 🖋 family of packages.
let package = Package(
	name: "Nib-Core",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.tvOS(.v13),
		.watchOS(.v6)
	],
	products: [
		.library(
			name: "🖋Core",
			targets: ["Core"]
		)
	],
	targets: [
		.target(
			name: "Core",
			dependencies: []
		),
		.testTarget(
			name: "CoreTests",
			dependencies: ["Core"]
		)
	],
	swiftLanguageVersions: [.v5]
)
