!/bin/bash

export MONO_SOURCE_ROOT=$HOME/Programming/mono
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_NDK_ROOT=$HOME/Android/android-ndk-r21e
export JAVA_HOME=$HOME/jdk-8u282-ojdkbuild-linux-x64

# Build the runtimes for 32-bit and 64-bit Linux.
./linux.py configure --target=x86 --target=x86_64
./linux.py make --target=x86 --target=x86_64

# Build the runtime for all supported Android ABIs.
./android.py configure --target=all-runtime
./android.py make --target=all-runtime

# Build the Desktop BCL.
./bcl.py make --product=desktop

#Copy linux BCL
./linux.py copy-bcl --target=x86 --target=x86_64

# Build the Android BCL.
./bcl.py make --product=android

#Install
./reference_assemblies.py install