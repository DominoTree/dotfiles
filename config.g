; Configuration file for SKR-RFF-E3-v1.1 (firmware version 3)
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v3.3.0-LPC-STM32+07 on Sun Nov 07 2021 14:03:27 GMT-0800 (Pacific Standard Time)

; General preferences
G90                                            ; send absolute coordinates...
M83                                            ; ...but relative extruder moves
M550 P"Ender3"                                 ; set printer name

; Network
M551 P"@s12er8iop"                             ; set password
M552 S1                                        ; enable network
M586 P0 S1                                     ; enable HTTP
M586 P1 S0                                     ; disable FTP
M586 P2 S0                                     ; disable Telnet

; Drives
M569 P0 S0                                     ; physical drive 0 goes backwards using TMC2209 driver timings
M569 P1 S0                                     ; physical drive 1 goes backwards using TMC2209 driver timings
M569 P2 S1                                     ; physical drive 2 goes forwards using TMC2209 driver timings
M569 P3 S1                                     ; physical drive 3 goes forwards using TMC2209 driver timings
M584 X0 Y1 Z2 E3                               ; set drive mapping
M350 X16 Y16 Z16 E16 I1                        ; configure microstepping with interpolation
M92 X80.00 Y80.00 Z400.00 E130.00              ; set steps per mm
M566 X900.00 Y900.00 Z60.00 E360.00            ; set maximum instantaneous speed changes (mm/min)
M203 X6000.00 Y6000.00 Z180.00 E1200.00        ; set maximum speeds (mm/min)
M201 X500.00 Y500.00 Z100.00 E5000.00          ; set accelerations (mm/s^2)
M906 X800 Y800 Z800 E800 I30                   ; set motor currents (mA) and motor idle factor in per cent
M84 S30                                        ; Set idle timeout

; Axis Limits
M208 X0 Y0 Z0 S1                               ; set axis minima
M208 X235 Y235 Z260 S0                         ; set axis maxima

; Endstops
M574 X1 S1 P"xstop"                            ; configure active-high endstop for low end on X via pin xstop
M574 Y1 S1 P"ystop"                            ; configure active-high endstop for low end on Y via pin ystop
M574 Z1 S2                                     ; configure Z-probe endstop for low end on Z

; Z-Probe
M950 S0 C"servo0"                              ; create servo pin 0 for BLTouch
M558 P9 C"^probe" H5 F120 T6000                ; set Z probe type to bltouch and the dive height + speeds
G31 P500 X-44 Y-16 Z2.24                       ; set Z probe trigger value, offset and trigger height
;M557 X15:215 Y15:195 S20                       ; define mesh grid
;G29 S0                                         ; probe the bed, save mesh, and activate
G29 S1                                         ; load saved bed mesh

; Heaters
M308 S0 P"bedtemp" Y"thermistor" T100000 B4092 ; configure sensor 0 as thermistor on pin bedtemp
M950 H0 C"bed" T0                              ; create bed heater output on bed and map it to sensor 0
M307 H0 B1 R0.293 C355.5 D3.46 S1.00 V24.0     ; enable bang-bang mode for the bed heater and set PWM limit
M140 H0                                        ; map heated bed to heater 0
M143 H0 S120                                   ; set temperature limit for heater 0 to 120C
M308 S1 P"e0temp" Y"thermistor" T100000 B4092  ; configure sensor 1 as thermistor on pin e0temp
M950 H1 C"e0heat" T1                           ; create nozzle heater output on e0heat and map it to sensor 1
M307 H1 B0 R2.645 C178.1:143.8 D4.35 S1.00 V24.0; disable bang-bang mode for heater  and set PWM limit
M143 H1 S245                                   ; set temperature limit for heater 1 to 245C

; Fans
M950 F0 C"fan0" Q500                           ; create fan 0 on pin fan0 and set its frequency
M106 P0 C"Part Cooling Fan" S0 H-1             ; set fan 0 name and value. Thermostatic control is turned off
M950 F1 C"fan1" Q500                           ; create fan 1 on pin fan1 and set its frequency
M106 P1 C"Hotend Fan" S0.01 H1 T45             ; set fan 1 name and value. Thermostatic control is turned on

; Tools
M563 P0 D0 H1 F0                               ; define tool 0
G10 P0 X-1 Y-16 Z0                             ; set tool 0 axis offsets
G10 P0 R0 S0                                   ; set initial tool 0 active and standby temperatures to 0C

; Custom settings are not defined

; Miscellaneous
M575 P1 S1 B115200                             ; enable support for tft
T0                                             ; select first tool

