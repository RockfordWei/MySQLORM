// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "MySQLORM",
    dependencies: [
        .Package(url:"https://github.com/PerfectlySoft/Perfect-MySQL.git", majorVersion: 2),
        .Package(url: "https://github.com/PerfectlySoft/PerfectLib.git", majorVersion: 2)
    ]
)
