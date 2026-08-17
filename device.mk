#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/motorola/xt2571

# VINTF
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# Soong namespace
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# API / VNDK
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_TARGET_VNDK_VERSION := 34

# Virtual A/B
AB_OTA_UPDATER := true
ENABLE_VIRTUAL_AB := true
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true
AB_OTA_PARTITIONS += \
    apusys \
    audio_dsp \
    boot \
    ccu \
    dpm \
    dtbo \
    gpueb \
    gz \
    lk \
    logo \
    mcf_ota \
    mcupm \
    md1img \
    mvpu_algo \
    odm \
    odm_dlkm \
    pi_img \
    preloader_raw \
    product \
    scp \
    spmfw \
    sspm \
    system \
    system_ext \
    system_dlkm \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vcp \
    vendor \
    vendor_boot \
    vendor_dlkm

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/mtk_plpath_utils \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL (MTK)
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-mtkimpl \
    android.hardware.boot@1.2-mtkimpl.recovery \
    bootctrl.mt6897 \
    bootctrl.mt6897.recovery

# Core update tooling
PRODUCT_PACKAGES += \
    libgptutils \
    libz \
    libcutils \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload \
    checkpoint_gc

# Health HAL
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service.rc

# MTK partition-layout path utility (erofs postinstall symlinks)
PRODUCT_PACKAGES += \
    mtk_plpath_utils \
    mtk_plpath_utils.recovery

# Security HALs
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1 \
    android.hardware.security.keymint \
    android.hardware.security.secureclock \
    android.hardware.security.sharedsecret \
    android.system.keystore2

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4

# Libraries relinked into recovery ramdisk
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hardware.keymaster@4.1 \
    android.hardware.vibrator-V1-ndk_platform \
    android.hardware.graphics.common@1.0 \
    libion \
    libxml2 \
    android.hardware.health@2.0-impl-default \
    android.hardware.boot@1.0

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@4.1.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.vibrator-V1-ndk_platform.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.graphics.common@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.health@2.0-impl-default.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.boot@1.0.so
