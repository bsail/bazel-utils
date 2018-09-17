cc_library(
  name = "cmock",
  srcs = glob(["src/*"]),
    copts = [
        "-Iexternal/unity/src/",
        "-Iexternal/unity/extras/fixture/src/",
    ],
    deps = [
        #"@unity//:unity",
        "@unity//:unity_framework",
    ],
  visibility = ["//visibility:public"],
)

filegroup(
    name = "cmock_rb",
    srcs = [
      "lib/cmock.rb",
    ],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "lib",
    srcs = glob(
        ["lib/*"],
        exclude = ["lib/cmock.rb"]
    ),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "config",
    srcs = glob(
        ["config/*"]
    ),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "create_runner",
    srcs = ["scripts/create_runner.rb"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "create_mock",
    srcs = ["scripts/create_mock.rb"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "readme",
    srcs = ["README.md"],
    path = ".",
    visibility = ["//visibility:public"],
)
