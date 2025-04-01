@echo off
"C:\\Users\\artas\\AppData\\Local\\Android\\sdk\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HC:\\flutter\\packages\\flutter_tools\\gradle\\src\\main\\groovy" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=21" ^
  "-DANDROID_PLATFORM=android-21" ^
  "-DANDROID_ABI=arm64-v8a" ^
  "-DCMAKE_ANDROID_ARCH_ABI=arm64-v8a" ^
  "-DANDROID_NDK=C:\\Users\\artas\\AppData\\Local\\Android\\sdk\\ndk\\27.0.12077973" ^
  "-DCMAKE_ANDROID_NDK=C:\\Users\\artas\\AppData\\Local\\Android\\sdk\\ndk\\27.0.12077973" ^
  "-DCMAKE_TOOLCHAIN_FILE=C:\\Users\\artas\\AppData\\Local\\Android\\sdk\\ndk\\27.0.12077973\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=C:\\Users\\artas\\AppData\\Local\\Android\\sdk\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=C:\\.Tugas\\Agile Software Development\\app1\\taskly\\build\\app\\intermediates\\cxx\\Debug\\3on586i6\\obj\\arm64-v8a" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=C:\\.Tugas\\Agile Software Development\\app1\\taskly\\build\\app\\intermediates\\cxx\\Debug\\3on586i6\\obj\\arm64-v8a" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-BC:\\.Tugas\\Agile Software Development\\app1\\taskly\\android\\app\\.cxx\\Debug\\3on586i6\\arm64-v8a" ^
  -GNinja ^
  -Wno-dev ^
  --no-warn-unused-cli
