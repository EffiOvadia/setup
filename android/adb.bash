# Check for connected devices and authorize connection (on the phone)
adb devices -l
  
# Enable call recording
adb shell settings put global op_voice_recording_supported_by_mcc 1
adb shell settings put system oem_force_enable_voice_recording true

# Enable Automatic Call Recording for All Calls in contact list
adb shell settings put global oplus_customize_all_call_audio_record 1

# Enable Automatic Call Recording for Calls from Strangers
adb shell settings put global oplus_customize_all_stranger_call_audio_record 1

# Set the maximum number of recordings to keep
adb shell settings put global oplus_customize_max_record_setting 3000

# Verify settings
adb shell settings get global op_voice_recording_supported_by_mcc
adb shell settings get system oem_force_enable_voice_recording
adb shell settings get global oplus_customize_all_call_audio_record
adb shell settings get global oplus_customize_all_stranger_call_audio_record

adb reboot
