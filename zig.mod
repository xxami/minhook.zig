id: 8b2c0ueyks0ap8dk9vyxxu7rm21pepebibzrsvzkl5k5qnoe
name: minhook
main: src/main.zig
c_include_dirs:
  - src/minhook
  - src/minhook/hde
  - src/minhook/include
c_source_files:
  - src/minhook/buffer.c
  - src/minhook/hook.c
  - src/minhook/trampoline.c
  - src/minhook/hde/hde64.c
c_source_flags:
  - -std=c11
  - -masm=intel
dependencies:
