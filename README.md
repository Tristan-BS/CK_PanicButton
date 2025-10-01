# 🚨 CK_PanicButton

A lightweight **Panic Button script** for **ESX-based FiveM servers**.  
It allows police, sheriff, and ambulance jobs to trigger an **emergency signal (panic button)**.  
Other authorized players receive a **notification, sound, GPS routing, and a red danger zone**.  

---

## ✨ Features
- ✅ ESX support (Legacy & compatible versions)  
- ✅ Configurable allowed jobs (Police, Sheriff, EMS, etc.)  
- ✅ Optional item requirement (panic button & phone)  
- ✅ Anti-spam cooldown system  
- ✅ Customizable key bindings (panic, accept GPS, decline GPS)  
- ✅ Notifications with sound  
- ✅ Two panic button types:
  - **Type 1 (Static GPS)** → fixed position, no live updates  
  - **Type 2 (Live GPS Updates)** → continuously updating position with every interval  
- ✅ Dynamic blips:  
  - GPS route (if accepted)  
  - Red danger radius (pulse & flash)  
  - Automatic removal after expiration  

---

## ⚙️ Installation
1. Place the resource in your `resources/[selfmade]` (or similar) folder:  
   ```bash
     ensure CK_PanicButton
   ```

2. Add the panic button item to your [database](item/panicbutton.sql) (if `RequireItem = true`):

---

## 🔀 Panic Button Types

### 🔹 Type 1 – **Static GPS (No Updates)**

* When triggered, a blip is created at the initial location.
* Officers can accept/decline the GPS route.
* The location **does not update** after the initial trigger.

### 🔹 Type 2 – **Live GPS Updates**

* Works the same as Type 1, **but**:

  * The location is updated every `Config.Blip.UpdateInterval` seconds.
  * A new red danger radius is drawn at the latest location.
* Officers are asked again to accept GPS if they previously declined.

---

## 🖥️ Commands & Keybinds

* `/panic` → Triggers the panic button (if allowed)
* Default key for panic: **Z**
* Default key to accept GPS: **Page Up**
* Default key to decline GPS: **Page Down**

All keybinds can be changed in **ESC → Key Bindings**.

---

## 📜 License

MIT License – free to use, modify, and share.
