// swift-tools-version:4.2
import PackageDescription

let package = Package(

	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",

	products: [
		.library(
			name: "Nib",
			targets: ["Core"]
		),
	],

	dependencies: [

	],

	targets: [
		.target(
			name: "Core",
			dependencies: []
		),
	],

	swiftLanguageVersions: [.v4_2]

)
