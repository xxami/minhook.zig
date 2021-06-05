const Builder = @import("std").build.Builder;
const deps = @import("./deps.zig");

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const zlib = b.addStaticLibrary("minhook", "src/main.zig");
    deps.addAllTo(zlib);
    zlib.setBuildMode(mode);
    zlib.install();
}
