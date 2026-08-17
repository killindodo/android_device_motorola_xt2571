LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),xt2571)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
