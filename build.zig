const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const cflags = &[_][]const u8{
        "-std=c11",
        "-masm=intel",
    };

    const mode = b.standardReleaseOptions();
    const zlib = b.addStaticLibrary("minhook", "src/main.zig");

    const clib = b.addStaticLibrary("cminhook", null);
    clib.addIncludeDir("src/minhook");
    clib.addIncludeDir("src/minhook/hde");
    clib.addCSourceFile("src/minhook/buffer.c", cflags);
    clib.addCSourceFile("src/minhook/hook.c", cflags);
    clib.addCSourceFile("src/minhook/trampoline.c", cflags);
    clib.addCSourceFile("src/minhook/hde/hde64.c", cflags);
    clib.linkLibC();
    
    zlib.setBuildMode(mode);
    zlib.linkLibrary(clib);
    zlib.install();
}
