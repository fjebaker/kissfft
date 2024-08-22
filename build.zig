const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});

    const lib = b.addStaticLibrary(.{
        .name = "kissfft",
        .target = target,
        .optimize = .ReleaseFast,
    });
    lib.linkLibC();
    lib.addCSourceFile(.{ .file = b.path("kiss_fft.c") });
    lib.installHeader(b.path("kiss_fft.h"), "kiss_fft.h");

    b.installArtifact(lib);
}
