#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from product configurations
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit OrangeFox / TWRP common
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from device
$(call inherit-product, device/motorola/xt2571/device.mk)

# Virtual A/B with vendor ramdisk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Emulated storage
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

PRODUCT_DEVICE := xt2571
PRODUCT_NAME := twrp_xt2571
PRODUCT_BRAND := motorola
PRODUCT_MODEL := Moto Pad 60 Pro
PRODUCT_MANUFACTURER := motorola

# Vendor boot recovery & FUSE passthrough
PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.vendor_boot=true \
    persist.sys.fuse.passthrough.enable=true
