// swift-tools-version:4.2
import PackageDescription

let package = Package(

	/// ✒💦 A Swift implementation of XSD datatypes for RDF.
	name: "Nib",

	products: [
		.library(
			name: "Nib",
			targets: [
//				"EBNF",
//				"XML11",
//				"XSD"
			]
		),
	],

	dependencies: [

	],

	targets: [
//		.target(
//			name: "EBNF",
//			dependencies: []
//		),
//		.target(
//			name: "XML11",
//			dependencies: ["EBNF"]
//		),
//		.target(
//			name: "XSD",
//			dependencies: ["XML11"]
//		),
//		.testTarget(
//			name: "XML11Tests",
//			dependencies: ["XML11"]
//		),
//		.testTarget(
//			name: "XSDTests",
//			dependencies: ["XSD"]
//		)
	],

	swiftLanguageVersions: [.v4_2]

)
