#
# Copyright (C) 2013 The CyanogenMod Project
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

PRODUCT_LOCALES += hdpi
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

# (2) Also get non-open-source specific aspects if available
$(call inherit-product-if-exists, vendor/samsung/logan2g/logan2g-vendor.mk)

# Language
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Use the Dalvik VM specific for devices with 512 MB of RAM
$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

# overlays
DEVICE_PACKAGE_OVERLAYS += device/samsung/logan2g/overlay

LOCAL_PATH := device/samsung/logan2g

# Softlink sh
$(shell mkdir -p $(LOCAL_PATH)/../../../out/target/product/logan2g/recovery/root/system/bin)
$(shell ln -sf -t $(LOCAL_PATH)/../../../out/target/product/logan2g/recovery/root/system/bin ../../sbin/sh)

# Init Files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/init.sc6820i.rc:root/init.sc6820i.rc \
    $(LOCAL_PATH)/rootdir/init.sc6820i.usb.rc:root/init.sc6820i.usb.rc \
    $(LOCAL_PATH)/rootdir/fstab.sc6820i:root/fstab.sc6820i \
	$(LOCAL_PATH)/rootdir/lpm.rc:root/lpm.rc \
    $(LOCAL_PATH)/rootdir/ueventd.sc6820i.rc:root/ueventd.sc6820i.rc \
    $(LOCAL_PATH)/rootdir/bin/charge:root/bin/charge \
    $(LOCAL_PATH)/rootdir/bin/poweroff_alarm:root/bin/poweroff_alarm \
    $(LOCAL_PATH)/rootdir/bin/rawdatad:root/bin/rawdatad

# Camera
PRODUCT_PACKAGES += \
	camera.sc6820i
	
# Graphics
PRODUCT_PACKAGES += \
	gralloc.sc6820i \
	libUMP

# Idc
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/idc/Zinitix_tsp.idc:system/usr/idc/Zinitix_tsp.idc

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/keylayouts/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/configs/keylayouts/sci-keypad.kl:system/usr/keylayout/sci-keypad.kl

#Wifi
PRODUCT_PACKAGES += \
	dhcpcd.conf \
	wpa_supplicant \
	hostapd \
	wpa_supplicant.conf

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default \
    tinymix \
    libtinyalsa
    
# Board-Pecific
PRODUCT_PACKAGES += \
   	lights.sc6820i \

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp

# Charger
PRODUCT_PACKAGES += \
    charger \
    charger_res_images
    
# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml
    
    
# Filesystem management tools
PRODUCT_PACKAGES += \
    setup_fs

# Misc packages
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory
    
# Samsung Service Mode
PRODUCT_PACKAGES += \
    SamsungServiceMode \
    Gallery2
    
# Web
PRODUCT_PACKAGES += \
    libskia_legacy

# Wifi
$(call inherit-product, hardware/broadcom/wlan/bcmdhd/config/config-bcm.mk)

# Graphics
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072 \


# These are the hardware-specific settings that are stored in system properties.
# Note that the only such settings should be the ones that are too low-level to
# be reachable from resources or other mechanisms.
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.supplicant_scan_interval=180


# Hw params
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/hw_params/audio_para:system/etc/audio_para \
     $(LOCAL_PATH)/hw_params/codec_pga.xml:system/etc/codec_pga.xml\
     $(LOCAL_PATH)/hw_params/tiny_hw.xml:system/etc/tiny_hw.xml

# Device props
PRODUCT_PROPERTY_OVERRIDES := \
	keyguard.no_require_sim=true \
	ro.com.android.dataroaming=false \
	persist.sys.sprd.modemreset=0


# enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1

# Extended JNI checks
# The extended JNI checks will cause the system to run more slowly, but they can spot a variety of nasty bugs
# before they have a chance to cause problems.
# Default=true for development builds, set by android buildsystem.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=0 \
    dalvik.vm.checkjni=false \
    wifi.interface=wlan0 \
    ro.zygote.disable_gl_preload=true \
    persist.msms.phone_count=2 \
    persist.radio.multisim.config=dsds \
    ro.telephony.call_ring.multiple=0 \
    dalvik.vm.heapgrowthlimit=46m \
    dalvik.vm.heapsize=92m \
    ro.telephony.ril_class=SamsungLogan2GRIL
    ro.telephony.call_ring=0 


PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=adb,mtp \
    ro.adb.secure=0 \
    ro.secure=0 \
    ro.debuggable=1

    
# ART device props
PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.dex2oat-Xms=8m \
	dalvik.vm.dex2oat-Xmx=96m \
	dalvik.vm.dex2oat-flags=--no-watch-dog \
	dalvik.vm.dex2oat-filter=interpret-only \
	dalvik.vm.image-dex2oat-Xms=48m \
	dalvik.vm.image-dex2oat-Xmx=48m \
	dalvik.vm.image-dex2oat-filter=speed

# Audio
PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.primary.sc6820i \
	audio.r_submix.default \
	audio.usb.default \
	audio_vbc_eq \
	libaudio-resampler \
	libatchannel \
	libtinyalsa
    
# Force use old camera api
PRODUCT_PROPERTY_OVERRIDES += \
    camera2.portability.force_api=1
    
PRODUCT_TAGS += dalvik.gc.type-precise 
    
# Boot animation
TARGET_SCREEN_HEIGHT := 800
TARGET_SCREEN_WIDTH := 480
