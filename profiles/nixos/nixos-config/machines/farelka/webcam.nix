{ lib, pkgs, ... } :
{
    hardware.ipu6 = {
        enable = true;
        platform = "ipu6ep";
    };
    # Intel IPU6 / LJCA webcam bridge power rule
    services.udev.extraRules = ''
          ACTION=="add", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="8086", ATTR{idProduct}=="0b63", TEST=="power/control", ATTR{power/control}="on"
    '';

    # Lock icamerasrc to 720p30 NV12 so WebRTC resolution changes never reset csi2-1
    systemd.services.v4l2-relayd-ipu6.script = lib.mkForce ''
      exec ${pkgs.v4l2-relayd}/bin/v4l2-relayd \
        -i "icamerasrc ! video/x-raw,format=NV12,width=1280,height=720,framerate=30/1" \
        -o "appsrc name=appsrc caps=video/x-raw,format=NV12,width=1280,height=720,framerate=30/1 ! videoconvert ! video/x-raw,format=YUY2 ! queue ! v4l2sink name=v4l2sink device=$(cat $V4L2_DEVICE_FILE)"
    '';
}
