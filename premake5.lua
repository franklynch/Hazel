workspace "Hazel"
	architecture "x64"
	startproject "Sandbox"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}" 

IncludeDir = {}
IncludeDir["GLFW"] = "Hazel/vendor/GLFW/include"

include "Hazel/vendor/GLFW"




project "Hazel"
		location "Hazel"
		kind "SharedLib"
		language "C++"

		targetdir ("bin/" .. outputdir .. "/%{prj.name}")
		objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

		
		pchheader "stdafx.h"
		pchsource "Hazel/src/stdafx.cpp"
		

     
		files
		{
			"%{prj.name}/src/**.h",
			"%{prj.name}/src/**.cpp"
		}

		includedirs
		{
			"%{prj.name}/src/",
			"%{prj.name}/vendor/spdlog/include",
			"%{IncludeDir.GLFW}"
		}

		links
		{
			"GLFW",
			"opengl32.lib"
		}
		

	

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"
		buildoptions { "/utf-8" }
	
	

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL"
		}

		postbuildcommands
		{
		
			("{COPYFILE} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}


	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "On"
		buildoptions "/MDd"
	

	filter "configurations:Release"
		defines "HZ_Release"
		optimize "On"
		buildoptions "/MD"
	

	filter "configurations:Dist"
		defines "HZ_Dist"
		optimize "On"
		buildoptions "/MD"
	

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Hazel/src/",
		"Hazel/vendor/spdlog/include"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"
		buildoptions { "/utf-8" }


	defines
	{
		"HZ_PLATFORM_WINDOWS"
	}

	links
	{
		"Hazel"
	}


	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "On"
		buildoptions "/MDd"
	

	filter "configurations:Release"
		defines "HZ_Release"
		optimize "On"
		buildoptions "/MD"
	

	filter "configurations:Dist"
		defines "HZ_Dist"
		optimize "On"
		buildoptions "/MD"
	