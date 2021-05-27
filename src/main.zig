const std = @import("std");
usingnamespace std.os.windows;

const MH_STATUS = enum(u32) {
    // Unknown error. Should not be returned.
    MH_UNKNOWN = -1,

    // Successful.
    MH_OK = 0,

    // MinHook is already initialized.
    MH_ERROR_ALREADY_INITIALIZED,

    // MinHook is not initialized yet, or already uninitialized.
    MH_ERROR_NOT_INITIALIZED,

    // The hook for the specified target function is already created.
    MH_ERROR_ALREADY_CREATED,

    // The hook for the specified target function is not created yet.
    MH_ERROR_NOT_CREATED,

    // The hook for the specified target function is already enabled.
    MH_ERROR_ENABLED,

    // The hook for the specified target function is not enabled yet, or already
    // disabled.
    MH_ERROR_DISABLED,

    // The specified pointer is invalid. It points the address of non-allocated
    // and/or non-executable region.
    MH_ERROR_NOT_EXECUTABLE,

    // The specified target function cannot be hooked.
    MH_ERROR_UNSUPPORTED_FUNCTION,

    // Failed to allocate memory.
    MH_ERROR_MEMORY_ALLOC,

    // Failed to change the memory protection.
    MH_ERROR_MEMORY_PROTECT,

    // The specified module is not loaded.
    MH_ERROR_MODULE_NOT_FOUND,

    // The specified function is not found.
    MH_ERROR_FUNCTION_NOT_FOUND
};

// Can be passed as a parameter to MH_EnableHook, MH_DisableHook,
// MH_QueueEnableHook or MH_QueueDisableHook.
const MH_ALL_HOOKS = NULL;

// Initialize the MinHook library. You must call this function EXACTLY ONCE
// at the beginning of your program.
pub extern fn MH_Initialize() callconv(.Stdcall) MH_STATUS;

// Uninitialize the MinHook library. You must call this function EXACTLY
// ONCE at the end of your program.
pub extern fn MH_Uninitialize() callconv(.Stdcall) MH_STATUS;

// Creates a hook for the specified target function, in disabled state.
// Parameters:
//   pTarget     [in]  A pointer to the target function, which will be
//                     overridden by the detour function.
//   pDetour     [in]  A pointer to the detour function, which will override
//                     the target function.
//   ppOriginal  [out] A pointer to the trampoline function, which will be
//                     used to call the original target function.
//                     This parameter can be NULL.
pub extern fn MH_CreateHook(pTarget: LPVOID, pDetour: LPVOID, ppOriginal: *LPVOID) callconv(.Stdcall) MH_STATUS;

// Creates a hook for the specified API function, in disabled state.
// Parameters:
//   pszModule   [in]  A pointer to the loaded module name which contains the
//                     target function.
//   pszProcName [in]  A pointer to the target function name, which will be
//                     overridden by the detour function.
//   pDetour     [in]  A pointer to the detour function, which will override
//                     the target function.
//   ppOriginal  [out] A pointer to the trampoline function, which will be
//                     used to call the original target function.
//                     This parameter can be NULL.
pub extern fn MH_CreateHookApi(pszModule: LPCWSTR, pszProcName: LPCSTR, pDetour: LPVOID, ppOriginal: *LPVOID) callconv(.Stdcall) MH_STATUS;

// Creates a hook for the specified API function, in disabled state.
// Parameters:
//   pszModule   [in]  A pointer to the loaded module name which contains the
//                     target function.
//   pszProcName [in]  A pointer to the target function name, which will be
//                     overridden by the detour function.
//   pDetour     [in]  A pointer to the detour function, which will override
//                     the target function.
//   ppOriginal  [out] A pointer to the trampoline function, which will be
//                     used to call the original target function.
//                     This parameter can be NULL.
//   ppTarget    [out] A pointer to the target function, which will be used
//                     with other functions.
//                     This parameter can be NULL.
pub extern fn MH_CreateHookApiEx(pszModule: LPCWSTR, pszProcName: LPCSTR, pDetour: LPVOID, ppOriginal: *LPVOID, ppTarget: *LPVOID) callconv(.Stdcall) MH_STATUS;

// Removes an already created hook.
// Parameters:
//   pTarget [in] A pointer to the target function.
pub extern fn MH_RemoveHook(pTarget: LPVOID) callconv(.Stdcall) MH_STATUS;

// Enables an already created hook.
// Parameters:
//   pTarget [in] A pointer to the target function.
//                If this parameter is MH_ALL_HOOKS, all created hooks are
//                enabled in one go.
pub extern fn MH_EnableHook(pTarget: LPVOID) callconv(.Stdcall) MH_STATUS;

// Disables an already created hook.
// Parameters:
//   pTarget [in] A pointer to the target function.
//                If this parameter is MH_ALL_HOOKS, all created hooks are
//                disabled in one go.
pub extern fn MH_DisableHook(pTarget: LPVOID) callconv(.Stdcall) MH_STATUS;

// Queues to disable an already created hook.
// Parameters:
//   pTarget [in] A pointer to the target function.
//                If this parameter is MH_ALL_HOOKS, all created hooks are
//                queued to be disabled.
pub extern fn MH_QueueDisableHook(pTarget: LPVOID) callconv(.Stdcall) MH_STATUS;

// Applies all queued changes in one go.
pub extern fn MH_ApplyQueued() callconv(.Stdcall) MH_STATUS;

// Translates the MH_STATUS to its name as a string.
pub extern fn MH_StatusToString(status: MH_STATUS) callconv(.Stdcall) [*c]const u8;
