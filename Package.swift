// swift-tools-version:5.5
import PackageDescription

/// __🖋🥑 Nib Core:__ Core types and behaviours for the 🖋 Nib family of packages.
let package = Package(
	name: "Nib-Core",
	platforms: [
        .macOS(.v11),
        .iOS(.v14),
        .watchOS(.v7),
        .tvOS(.v13)
	],
	products: [
		.library(
			name: "Nib·Core",
			targets: ["Nib·Core"]
		)
	],
	dependencies: [
		.package(
			url: "https://github.com/apple/swift-algorithms",
			.upToNextMinor(
				from: Version(0, 2, 1)
			)
		),
		.package(
			url: "https://github.com/apple/swift-collections",
			.upToNextMinor(
				from: Version(0, 0, 3)
			)
		)
	],
	targets: [
		.target(
			name: "Nib·Core",
			dependencies: [
				.product(
					name: "Algorithms",
					package: "swift-algorithms"
				),
				.product(
					name: "OrderedCollections",
					package: "swift-collections"
				)
			]
//		),
//		.testTarget(
//			name: "CoreTests",
//			dependencies: ["Nib·Core"]
		)
	],
	swiftLanguageVersions: [.v5]
)
