load("@avr_tools//tools/avr:hex.bzl", "hex", "eeprom", "listing")
load("//utils:unity_runner_generator.bzl", "cmock_generate")

def custom_cc_libary(name, srcs, hdr, **kwargs):
  """Create a Unity test runner for the src source file.

  The generated file is prefixed with 'runner_'.
  """
  native.cc_library(
    name = name,
    srcs = srcs,
    hdrs = [hdr],
    copts = select({
        ":avr": ["-mmcu=$(MCU)"],
        "//conditions:default": [],
    }),
    includes = [
        "./inc/",
        ],
    linkopts = select({
        ":avr": ["-mmcu=$(MCU)"],
        "//conditions:default": [],
    }),
    **kwargs
  )

def custom_cc_libary_mock(name, hdr, deps, **kwargs):
  """Create a Unity test runner for the src source file.

  The generated file is prefixed with 'runner_'.
  """
  native.cc_library(
    name = "mock_"+name,
    srcs = [
        "src/mock_"+name+".c",
        ],
    hdrs = [
        "inc/mock_"+name+".h",
        hdr,
        ],
    includes = [
        "./inc/",
        ],
    copts = [
        "-Iexternal/unity/src/",
        "-Iexternal/unity/extras/fixture/src/",
        "-Iexternal/cmock/src/",
        "-Isrc/lib/inc/",
    ],
    deps = [
        "@cmock//:cmock",
    ],
    **kwargs
  )
