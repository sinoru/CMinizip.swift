// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let coreSources = ["mz","mz_os","mz_os_posix","mz_compat","mz_crypt","mz_strm","mz_strm_mem","mz_strm_buf","mz_strm_crypt","mz_strm_os_posix","mz_strm_zlib","mz_zip","mz_zip_rw","mz_strm_split"].map { "minizip/\($0).c" }
let pkcryptSources = ["mz_strm_pkcrypt"].map { "minizip/\($0).c" }
let appleWZAESSources = ["mz_strm_wzaes", "mz_crypt_apple"].map { "minizip/\($0).c" }
let bzip2Sources = ["mz_strm_bzip"].map { "minizip/\($0).c" }

let package = Package(
    name: "CMinizip",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "CMinizip",
            targets: ["CMinizip", "CMinizipPKCRYPT", "CMinizipAppleWZAES", "CMinizipBZIP2"]),
        .library(
            name: "CMinizipCore",
            targets: ["CMinizip"]),
        .library(
            name: "CMinizipPKCRYPT",
            targets: ["CMinizipPKCRYPT"]),
        .library(
            name: "CMinizipAppleWZAES",
            targets: ["CMinizipAppleWZAES"]),
        .library(
            name: "CMinizipBZIP2",
            targets: ["CMinizipBZIP2"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "CMinizip",
            sources: coreSources,
            cSettings: [
                .define("HAVE_INTTYPES_H"),
                .define("HAVE_STDINT_H"),
                .define("HAVE_ZLIB")
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedLibrary("iconv")
            ]),
        .target(
            name: "CMinizipPKCRYPT",
            dependencies: [
                .target(name: "CMinizip")
            ],
            sources: pkcryptSources,
            cSettings: [
                .define("HAVE_PKCRYPT")
            ]),
        .target(
            name: "CMinizipAppleWZAES",
            dependencies: [
                .target(name: "CMinizip")
            ],
            sources: appleWZAESSources,
            cSettings: [
                .define("HAVE_WZAES")
            ]),
        .target(
            name: "CMinizipBZIP2",
            dependencies: [
                .target(name: "CMinizip")
            ],
            sources: bzip2Sources,
            cSettings: [
                .define("HAVE_BZIP2")
            ]),
    ]
)
