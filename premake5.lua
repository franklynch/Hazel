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
IncludeDir["Glad"] = "Hazel/vendor/Glad/include"
IncludeDir["ImGui"] = "Hazel/vendor/imgui"

group "Dependencies"
	include "Hazel/vendor/GLFW"
	include "Hazel/vendor/Glad"
	include "Hazel/vendor/imgui"

group ""

startproject "Sandbox"


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
			"%{IncludeDir.GLFW}",
			"%{IncludeDir.Glad}",
			"%{IncludeDir.ImGui}"
		}

		links
		{
			"GLFW",
			"Glad",
			"ImGui",
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
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		postbuildcommands
		{
				
			("{COPYFILE} %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/Sandbox/\"")
		}


	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		symbols "On"
	

	filter "configurations:Release"
		defines "HZ_Release"
		optimize "On"
		runtime "Release"
	

	filter "configurations:Dist"
		defines "HZ_Dist"
		optimize "On"
		runtime "Release"
	

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	staticruntime "off"
	

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
		runtime "Debug"
	

	filter "configurations:Release"
		defines "HZ_Release"
		optimize "On"
		runtime "Release"
	

	filter "configurations:Dist"
		defines "HZ_Dist"
		optimize "On"
		runtime "Release"
	