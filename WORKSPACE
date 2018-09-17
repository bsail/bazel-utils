http_archive(
    name = "avr_tools",
    sha256 = "09b64a154f57a859b08b063abadbced4e2b82910d30e111813169f2763cdce34",
    strip_prefix = "bazel-avr-tools-master",
    urls = [
        "https://github.com/bsail/bazel-avr-tools/archive/master.zip",
    ],
)

new_http_archive(
    name = "unity",
    url = "https://github.com/ThrowTheSwitch/Unity/archive/v2.4.1.zip",
    build_file = "unity.BUILD",
    sha256 = "f1c7a30917be617668a5a2608f1185338ce58f51e7ba3c8247dcb76263bc2e96",
    strip_prefix = "Unity-2.4.1",
)

git_repository(
    name = "gtest",
    remote = "https://github.com/google/googletest",
    commit = "2fe3bd994b3189899d93f1d5a881e725e046fdc2",
)

new_http_archive(
    name = "fff",
    url = "https://github.com/meekrosoft/fff/archive/master.zip",
    build_file = "fff.BUILD",
    strip_prefix = "fff-master",
)

new_http_archive(
    name = "cmock",
    url = "https://github.com/ThrowTheSwitch/CMock/archive/v2.4.6.zip",
    sha256 = "8fa6dcb88778e029dd4a69ce7d3df529f9f022e5b6ec93ae378cd8b898eb05d4",
    build_file = "cmock.BUILD",
    strip_prefix = "CMock-2.4.6",
)
