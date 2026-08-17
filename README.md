# Custom Recovery (OrangeFox / TWRP 12.1) Device Tree for Moto Pad 60 Pro (`XT2571-1`)

Device tree to compile OrangeFox Recovery (R12.1) or TWRP 12.1 for the **Motorola Moto Pad 60 Pro** (and hardware-equivalent **Lenovo Idea Tab Pro 12.7 / Xiaoxin Pad Pro 12.7 2025**, codename `peridot` / `tb375fc` / `tb373fu`).

---

## 📱 Device Specifications

| Feature | Details |
| :--- | :--- |
| **Device** | Motorola Moto Pad 60 Pro (`XT2571-1`) |
| **Hardware Twin** | Lenovo Idea Tab Pro 12.7 (`TB375FC` / `TB373FU`) |
| **Chipset** | MediaTek Dimensity 8300 (`MT6897` / `MT8792`) |
| **CPU** | Octa-core (4x Cortex-A715 @ 3.35 GHz + 4x Cortex-A510 @ 2.2 GHz) |
| **GPU** | ARM Mali-G615 MC6 |
| **Display** | 12.7" 2944 × 1840 (3K) 144Hz IPS LCD, Novatek NT36532 Touch IC |
| **Storage & RAM** | 128GB / 256GB UFS 4.0 + MicroSD Slot, 8GB / 12GB LPDDR5X |
| **Battery** | 10,200 mAh (45W Fast Charging) |
| **Shipped OS** | Android 14 / Android 15 (ZUI / Hello UI) with Kernel 6.1 GKI |

---

## 🧩 Partition & Recovery Architecture

- **Architecture:** Android GKI Boot Header **v4**
- **Recovery Location:** Embedded inside **`vendor_boot.img`** (no standalone `recovery` partition)
- **Dynamic Partitions:** Super partition (6.4 GB) with `system`, `system_ext`, `vendor`, `product`, `system_dlkm`, `vendor_dlkm`, `odm_dlkm` formatted in **EROFS**
- **Internal Storage:** `/dev/block/by-name/userdata` formatted in **F2FS**
- **Kernel Load Base:** `0x40000000` | **DTB & Tags Address:** `0x47c80000`

---

## 🚀 Status & Working Features

- [x] **DRM/KMS Graphics Commit:** Native 2944×1840 framebuffer rendering at full refresh rate.
- [x] **Touchscreen:** Novatek `NT36532` capacitive multi-touch + active stylus digitizer.
- [x] **Internal Storage (`/sdcard` / `/data`):** Full read/write mount support (~225 GB free).
- [x] **Dynamic Partitions:** Live userspace mounting of `/system_root`, `/vendor`, `/product`, and `/system_ext` EROFS images from `super`.
- [x] **Watchdog & System Stability:** Integrated early MTK hardware watchdog modules (zero bootloops or 9s resets).
- [x] **Hardware Telemetry:** Battery capacity/charging status and thermal sensor polling.
- [x] **External Storage:** MicroSD Card slot and USB-OTG drive mounting.
- [x] **ADB & Sideload:** Full `adbd`, interactive `bash`/`toybox` shell, and `adb sideload` zip flashing.
- [x] **Boot Control HAL:** Hardware A/B slot switching (`bootctl`).

---

## 🛠️ How to Build from Source

### 1. Initialize the Build Environment
Clone the OrangeFox / TWRP 12.1 source manifest:
```bash
mkdir ~/orangefox && cd ~/orangefox
repo init -u https://gitlab.com/OrangeFox/Manifest.git -b fox_12.1 --depth=1
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
```

### 2. Place this Device Tree
```bash
git clone https://github.com/killindodo/android_device_motorola_xt2571 device/motorola/xt2571
```

### 3. Compile `vendor_boot.img`
```bash
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_AB_DEVICE=1
export FOX_VIRTUAL_AB_DEVICE=1
export OF_MAINTAINER="KillinDoDo"
export FOX_BUILD_TYPE="Unofficial"

source build/envsetup.sh
lunch twrp_xt2571-eng
make -j$(nproc) vendorbootimage
```

The output file will be generated at:
`out/target/product/xt2571/vendor_boot.img`

---

## ⚡ Installation via Fastboot

> [!WARNING]
> Your device bootloader must be unlocked before flashing.

### Step 1: Reboot to Bootloader
```bash
adb reboot bootloader
```

### Step 2: Check Active Slot
```bash
fastboot getvar current-slot
```

### Step 3: Flash to Active Slot (e.g. slot `a`)
```bash
fastboot flash vendor_boot_a vendor_boot.img
```
*(If active slot is `b`, replace with `vendor_boot_b`).*

### Step 4: Reboot to Recovery
```bash
fastboot reboot recovery
```

---

## 👥 Credits & Acknowledgments

- **[lossantospro](https://github.com/lossantospro)** — Initial OrangeFox / TWRP recovery base tree.
- **TeamWin Recovery Project (TWRP)** & **OrangeFox Recovery Project** for the recovery core and theme engine.
- **Motorola Mobility LLC** & **Lenovo** for device firmware and kernel source releases.
- **[KillinDoDo](https://github.com/killindodo)** — Device tree bringup for Moto Pad 60 Pro (`XT2571-1`), GKI v4 kernel module extraction, SEPolicy harmonization, and storage fixes.
