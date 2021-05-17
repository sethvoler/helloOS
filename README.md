# HelloOS

## 使用

```bash
$ make
```

## 启动配置代码

```
menuentry 'HelloOS' {
  insmod part_msdos #GRUB加载分区模块识别分区
  insmod ext2 #GRUB加载ext文件系统模块识别ext文件系统
  #注意boot目录挂载的分区，这里需要根据自己的机器目录修改
  set root='hd0,msdos5'
  multiboot2 /boot/HelloOS.bin #GRUB以multiboot2协议加载HelloOS.bin
  boot #GRUB启动HelloOS.bin
}
```

- 把上面启动项的代码写入 `/boot/grub/grub.cfg` 文件中，
- 将编译生成的 `HelloOS.bin` 文件复制到 `/boot/` 目录下
