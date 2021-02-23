// swift-tools-version:5.3
import PackageDescription

/// __Nib ✒💦:__ A Swift implementation of the XML suite of specifications.
let package = Package(

	name: "Nib",

	products: [
		.library(
			name: "Nib",
			targets: ["Core"]
		)
	],

	dependencies: [

	],

	targets: [
		.target(
			name: "Core",
			dependencies: [],
			exclude: ["Documentation"]
		)
	],

	swiftLanguageVersions: [.v5]

)
