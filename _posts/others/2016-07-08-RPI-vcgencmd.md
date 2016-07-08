---
layout: post
title: RPI vcgencmd usage
category: 杂项
tags: vcgencmd raspberry pi
keywords: vcgencmd raspberry pi temperature
description: 
---

## RPI vcgencmd usage

`vcgencmd commands`

Shows a list of possible commands.

```
root@raspberrypi:~# vcgencmd commands
commands="vcos, ap_output_control, ap_output_post_processing, vchi_test_init, vchi_test_exit,
pm_set_policy, pm_get_status, pm_show_stats, pm_start_logging, pm_stop_logging, version, commands,
set_vll_dir, led_control, set_backlight, set_logging, get_lcd_info, set_bus_arbiter_mode,
cache_flush, otp_dump, codec_enabled, measure_clock, measure_volts, measure_temp, get_config,
hdmi_ntsc_freqs, render_bar, disk_notify, inuse_notify, sus_suspend, sus_status, sus_is_enabled,
sus_stop_test_thread, egl_platform_switch, mem_validate, mem_oom, mem_reloc_stats, file,
vctest_memmap, vctest_start, vctest_stop, vctest_set, vctest_get"
```

### vcgencmd measure_temp

Shows core temperature of BCM2835 SoC.

```
root@raspberrypi:~# vcgencmd measure_temp
temp=42.8'C
```

## Referance

[http://www.elinux.org/RPI_vcgencmd_usage](http://www.elinux.org/RPI_vcgencmd_usage)