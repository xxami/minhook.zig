const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const cflags = &[_][]const u8{
        "-std=c11",
        "-masm=intel",
    };

    const mode = b.standardReleaseOptions();
    const lib = b.addStaticLibrary("minhook", "src/minhook.zig");

    lib.addIncludeDir("src/minhook");
    lib.addIncludeDir("src/minhook/hde");
    lib.addCSourceFile("src/minhook/buffer.c", cflags);
    lib.addCSourceFile("src/minhook/hook.c", cflags);
    lib.addCSourceFile("src/minhook/trampoline.c", cflags);
    lib.addCSourceFile("src/minhook/hde/hde64.c", cflags);
    
    lib.setBuildMode(mode);
    lib.linkLibC();
    lib.install();
}
