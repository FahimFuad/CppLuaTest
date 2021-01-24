workspace "LightProjectSystem" -- Replace this name with your solution name
    architecture "x86_64"      -- Replace this architecture with your architecture

    configurations
    {
        "Debug",
        "Release"
    }
    flags -- Delete this flog scope if you dont want MultiProcessorCompile
    {
        "MultiProcessorCompile"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}" -- Dont touch this!

project "LightProjectSystem"  -- Replace this name with your project name
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}") -- Dont touch this!
    objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}") -- Dont touch this!

    files -- Dont touch this!
    {
        "src/**.h",
        "src/**.cpp"
    }

    includedirs
    {
        "src"
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
