# fw25-t6
FriendlyWrt 25.12.X for FriendlyARM NanoPC T6

## targets
1) friendlywrt based on openwrt-25.12.X
2) openclash
3) nft instead of iptables

## old luci-app(23.05)
1) luci-app-cpufreq -> unknown
2) luci-app-diskman -> no apk
3) luci-app-passwall -> openclash

## new luci-app list
1) luci-app-ddns
2) luci-app-dockerman
3) luci-app-firewall
4) luci-app-package-manager
5) luci-app-samba4
6) luci-app-statistics
7) luci-app-ttyd

## extract img.gz
1) gunzip T6-FriendlyWrt-25.12-docker.img.gz
2) file T6-FriendlyWrt-25.12-docker.img
3) use root or sudo to :
   1) kpartx -av T6-FriendlyWrt-25.12-docker.img
   2) blkid /dev/mapper/loop0p8
   3) mount -t ext4 -o ro /dev/mapper/loop0p8 /mnt/temp
   4) umount /mnt/temp
   5) kpartx -d /dev/loop0
   6) kpartx -dv T6-FriendlyWrt-25.12-docker.img
   7) dd if=/dev/mapper/loop0p1 of=./loop0p1.bin bs=4M
   8) hexdump -C ./loop0p1.bin | head -n 50

## partition
| Partition | Size | Mount |        Files        | Description |
|:---------:|:----:|:-----:|:-------------------:|:-----------:|
|  loop0p1  |  4M  |       | uboot+atf+optee+dtb |    uboot    |
|  loop0p2  |  4M  |       |                     |    misc     |
|  loop0p3  |  4M  |       |         dtb         |    dtbo     |
|  loop0p4  | 16M  |       |      logo+dtb       |  resource   |
|  loop0p5  | 40M  |       |       kernel        |   kernel    |
|  loop0p6  | 32M  |       |  initramfs(ubuntu)  |    boot     |
|  loop0p7  | 32M  |       |                     |  recovery   |
|  loop0p8  | 1.3G |   /   |      (openwrt)      |   rootfs    |
|  loop0p9  | 1.5G | /data |                     |  user-data  |
| loop0p10  | 462M | /opt  |       docker        | rootfs opt  |
