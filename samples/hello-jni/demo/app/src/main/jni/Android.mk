# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#---------------------------NDK 构建系统说明--------------------------------------------
#NDK构建系统是由多种GUN MakeFile片段构成，这些片段在NDK安装路径下的build/core中。整个构建系统还依赖于另外两个
#片段即Android.mk，与Application.mk,这两个文件由开发人员提供，构建系统期望这两个文件出现在jni子目录下!

#定位源文件（通过宏）
LOCAL_PATH := $(call my-dir)

#定位clear-vars.mk片段，用于清除除了LOCAL_PATH外所有LOCAL_<name>变量，如下面的：LOCAL_MODULE、LOCAL_SRC_FILES
#构建系统在单次执行中解析多个构建文件和模块定义，清除这些全局变量，避免发生冲突
include $(CLEAR_VARS)

#设置模块名称，生成的共享库名称将是：libhello-jni.so
LOCAL_MODULE    := hello-jni

#声明需要组装的源文件，多个文件以空格隔开
LOCAL_SRC_FILES := hello-jni.c

#构建共享库，为了供主应用程序使用的模块，必需将将该模块变成共享库，
#BUILD_SHARED_LIBRARY是指向build-shared-library.mk位置，该文件包含将源文件组装成共享库的必要过程
#Android应用程序不支持直接使用静态库，包中也不会包含静态库，但是NDK可以将静态库编译到动态库中。
#扩展：库是一种可执行代码的二进制形式，可以被操作系统载入内存执行。所谓静态、动态是指链接，库有两种：静态库（.a、.lib）和动态库（.so、.dll）。
include $(BUILD_SHARED_LIBRARY)
