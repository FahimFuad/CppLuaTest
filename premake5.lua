workspace "CppLua"
    architecture "x86_64"

    configurations
    {
        "Debug",
        "Release"
    }
    flags
    {
        "MultiProcessorCompile"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "CppLua"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "src/**.h",
        "src/**.cpp"
    }

    includedirs
    {
        "src",
        "%{wks.location}/src/vendor/lua/include"
    }

    libdirs
    {
        "%{wks.location}/src/vendor/lua/lib"
    }
    links
    {
        "lua54.lib"
    }

    postbuildcommands 
    {
        '{COPY} "src/vendor/lua/lib/lua54.dll" "%{cfg.targetdir}"'
    }

    filter "system:windows"
        systemversion "latest"

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "NDEBUG"
        runtime "Release"
        optimize "on"
