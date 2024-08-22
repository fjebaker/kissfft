const std = @import("std");

pub const DataType = enum {
    float,
    double,
    int16,
    int32,
    simd,
};

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});

    const dtype = b.option(
        DataType,
        "KISSFFT_DATATYPE",
        "The datatype to use (default: float).",
    ) orelse .float;

    const lib = b.addStaticLibrary(.{
        .name = "kissfft",
        .target = target,
        .optimize = .ReleaseFast,
    });
    lib.linkLibC();
    lib.addCSourceFile(.{ .file = b.path("kiss_fft.c") });
    lib.defineCMacro("KISSFFT_DATATYPE", @tagName(dtype));
    lib.installHeader(b.path("kiss_fft.h"), "kiss_fft.h");

    b.installArtifact(lib);
}
