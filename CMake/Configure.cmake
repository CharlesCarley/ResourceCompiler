# -----------------------------------------------------------------------------
#
#   Copyright (c) Charles Carley.
#
#   This software is provided 'as-is', without any express or implied
# warranty. In no event will the authors be held liable for any damages
# arising from the use of this software.
#
#   Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgment in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.
# ------------------------------------------------------------------------------
include(GitUpdate)
if (NOT GitUpdate_SUCCESS)
    return()
endif()

include(StaticRuntime)
include(GTestUtils)
include(ExternalTarget)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

option(ResourceCompiler_BUILD_TEST          "Build the unit test program." ON)
option(ResourceCompiler_AUTO_RUN_TEST       "Automatically run the test program." OFF)
option(ResourceCompiler_USE_STATIC_RUNTIME  "Build with the MultiThreaded(Debug) runtime library." ON)

if (ResourceCompiler_USE_STATIC_RUNTIME)
    set_static_runtime()
else()
    set_dynamic_runtime()
endif()


configure_gtest(${ResourceCompiler_SOURCE_DIR}/Test/googletest 
                ${ResourceCompiler_SOURCE_DIR}/Test/googletest/googletest/include)

DefineExternalTargetEx(
    Utils Extern
    ${ResourceCompiler_SOURCE_DIR}/Internal/Utils 
    ${ResourceCompiler_SOURCE_DIR}/Internal/Utils
    ${ResourceCompiler_BUILD_TEST}
    ${ResourceCompiler_AUTO_RUN_TEST}
)

set(Configure_SUCCEEDED TRUE)