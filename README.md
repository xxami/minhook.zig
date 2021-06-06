## minhook.zig
Zig binding to [minhook](https://github.com/TsudaKageyu/minhook) `x86_64 only`

## Requirements
- Zig compiler: https://ziglang.org/download/
- Zigmod package manager: https://github.com/nektro/zigmod

## Quickstart
Add to your zig.mod:
```yaml
dev_dependencies:
  - src: git https://github.com/xxami/minhook.zig
    name: minhook
    main: src/main.zig
```

Fetch:
```shell
$ zigmod fetch
```

Usage:
```C
const mh = @import("minhook");
mh.MH_Initialize();
```

Build:
```shell
$ zig build
```
