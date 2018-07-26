// swift-tools-version:4.2
import PackageDescription

let package = Package(

	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",

	products: [
		.library(name: "Nib", targets: ["Nib"]),
	],

	dependencies: [

	],

	targets: [
		.target(name: "Nib", dependencies: []),
		.testTarget(name: "NibTests", dependencies: ["Nib"]),
	],

	swiftLanguageVersions: [.v4_2]

)
