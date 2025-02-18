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
IncludeDir["glm"] = "Hazel/vendor/glm"

	include "Hazel/vendor/GLFW"
	include "Hazel/vendor/Glad"
	include "Hazel/vendor/imgui"
	
project "Hazel"
		location "Hazel"
		kind "StaticLib"
		language "C++"
		cppdialect "C++17"
		staticruntime "on"

		targetdir ("bin/" .. outputdir .. "/%{prj.name}")
		objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

		
		pchheader "stdafx.h"
		pchsource "Hazel/src/stdafx.cpp"
		

     
		files
		{
			"%{prj.name}/src/**.h",
			"%{prj.name}/src/**.cpp",
			"%{prj.name}/vendor/glm/glm/**.hpp",
			"%{prj.name}/vendor/glm/glm/**.inl"

		}

		includedirs
		{
			"%{prj.name}/src/",
			"%{prj.name}/vendor/spdlog/include",
			"%{IncludeDir.GLFW}",
			"%{IncludeDir.Glad}",
			"%{IncludeDir.ImGui}",
			"%{IncludeDir.glm}"
		}

		links
		{
			"GLFW",
			"Glad",
			"ImGui",
			"opengl32.lib"
		}
		

	

	filter "system:windows"
		systemversion "latest"
		buildoptions { "/utf-8" }
	
	

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE",
			"_CRT_SECURE_NO_WARNINGS"
			
		}

	


	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		symbols "on"
	

	filter "configurations:Release"
		defines "HZ_Release"
		runtime "Release"
		optimize "on"
		
	

	filter "configurations:Dist"
		defines "HZ_Dist"
		runtime "Release"
		optimize "on"
		
	

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"
	

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
		"Hazel/vendor/spdlog/include",
		"%{IncludeDir.glm}"
	}

	filter "system:windows"
		
		staticruntime "On"
		systemversion "latest"
		buildoptions { "/utf-8" }


	defines
	{
		"HZ_PLATFORM_WINDOWS",
	
	}

	links
	{
		"Hazel"
	}


	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		symbols "on"
		
	

	filter "configurations:Release"
		defines "HZ_Release"
		runtime "Release"
		optimize "on"
		
	

	filter "configurations:Dist"
		defines "HZ_Dist"
		runtime "Release"
		optimize "on"
