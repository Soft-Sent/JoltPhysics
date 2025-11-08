project "JoltPhysics"
	kind "StaticLib"
	language "C++"
	cppdialect "C++23"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files {
		"Jolt/**.h",
		"Jolt/**.cpp",
		"Jolt/**.inl",
	}

	includedirs {
		".",
	}

	defines { 
	  "JPH_ENABLE_ASSERTS"
	}

	filter "system:windows"
		systemversion "latest"
		
		-- Add natvis file for Visual Studio debugging
		files { "Jolt/Jolt.natvis" }

	filter "system:linux"
		pic "on"
		systemversion "latest"
		
		-- Pthread is required on Unix
		buildoptions { "-pthread" }
		linkoptions { "-pthread" }

	filter "configurations:Debug"
		runtime "Debug"
		symbols "On"
		defines { 
			"_DEBUG",
		}

	filter "configurations:Release"
		runtime "Release"
		optimize "Speed"  -- Optimize for speed, not size
		defines { "NDEBUG" }
		flags { "NoIncrementalLink" }

	filter "configurations:Distribution"
		runtime "Release"
		optimize "Full"  -- Maximum optimization
		symbols "Off"
		defines { "NDEBUG" }
		flags { "NoIncrementalLink" }

