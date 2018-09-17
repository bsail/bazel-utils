UNITY_COPTS = [
        "-Iexternal/unity/src/",
        "-Iexternal/unity/extras/fixture/src/",
        "-Iexternal/cmock/src/",
    ]
UNITY_DEPS = [
        "@unity//:unity",
        "@unity//:unity_framework",
        "@cmock//:cmock",
    ]
GTEST_COPTS = ["-Iexternal/gtest/include"]
GTEST_DEPS = [
        "@gtest//:gtest",
        "@gtest//:gtest_main", # Only if hello_test.cc has no main()
        "@fff//:fff",
    ]

def unity_runner(name, src, **kwargs):
  """Create a Unity test runner for the src source file.

  The generated file is prefixed with 'runner_'.
  """
  native.genrule(
    name = name,
    srcs = [src],
    outs = [name+".c"],
    tools = [
        "@cmock//:create_runner",
        "@unity//:auto",
        "@unity//:readme",
    ],
    cmd = "export UNITY_DIR=$$(pwd)/$$(dirname $(location @unity//:readme)) && \
      ruby $(location @cmock//:create_runner) $< $@",
    **kwargs
  )

def cmock_generator(prefix, src, where, type, **kwargs):
  """Create a Unity test runner for the src header file.

  The generated file is prefixed with 'Runner_'.
  """
  native.genrule(
    name = "mock_"+prefix+"_"+type,
    srcs = [src],
    outs = [where+"/mock_"+prefix+"."+type],
    tools = [
        "@cmock//:cmock_rb",
        "@cmock//:lib",
        "@cmock//:config",
        "@unity//:readme",
        "@unity//:auto",
        "@cmock//:readme",
        "@utils//mock:cmock_config",
    ],
    cmd = "export UNITY_DIR=$$(pwd)/$$(dirname $(location @unity//:readme)) && \
    export CMOCK_DIR=$$(pwd)/$$(dirname $(location @cmock//:readme)) && \
    export MOCK_OUT=. && \
    ruby $(location @cmock//:cmock_rb) -o$(location @utils//mock:cmock_config) $< && \
    cat mock_"+prefix+"."+type+" > $@",
    **kwargs
  )

def cmock_generate(prefix, src, **kwargs):
  cmock_generator(
      prefix = prefix,
      src = src,
      where = "inc",
      type = "h",
      **kwargs
  )
  cmock_generator(
      prefix = prefix,
      src = src,
      where = "src",
      type = "c",
      **kwargs
  )

def runner_unity_cmock(name, prefix, deps, **kwargs):
  unity_runner(
     name = "runner_"+prefix,
     src = prefix+".c",
  )
  native.cc_test(
    name = name,
    srcs = [
        prefix+".c",
        "runner_"+prefix+".c",
    ],
    copts = [
        "-Iexternal/unity/src/",
        "-Iexternal/unity/extras/fixture/src/",
        "-Iexternal/cmock/src/",
    ],
    deps = [
        "@unity//:unity",
        "@unity//:unity_framework",
        "@cmock//:cmock",
    ] + deps,
    **kwargs
  )

def runner_gtest_fff(name, prefix, deps, **kwargs):
  native.cc_test(
    name = name,
    srcs = [
        prefix+".c",
    ],
    copts = [
        "-Iexternal/gtest/include",
    ],
    deps = [
        "@gtest//:gtest",
        "@gtest//:gtest_main", # Only if hello_test.cc has no main()
        "@fff//:fff",
    ] + deps,
    **kwargs
  )
