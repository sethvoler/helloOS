#sethvoler @2021.05.17

#定义代表各个命令与参数的宏
#宏的使用方式 $(宏名)
MAKEFLAGS = -sR 
MKDIR = mkdir 
RMDIR = rmdir
CP = cp
CD = cd
DD = dd
RM = rm

ASM		= nasm
CC		= gcc
LD		= ld
OBJCOPY	= objcopy

ASMBFLAGS	= -f elf -w-orphan-labels
CFLAGS		= -c -Os -std=c99 -m32 -Wall -Wshadow -W -Wconversion -Wno-sign-conversion  -fno-stack-protector -fomit-frame-pointer -fno-builtin -fno-common  -ffreestanding  -Wno-unused-parameter -Wunused-variable
LDFLAGS		= -s -static -T hello.lds -n -Map HelloOS.map 
OJCYFLAGS	= -S -O binary

HELLOOS_OBJS :=
HELLOOS_OBJS += entry.o main.o vgastr.o
HELLOOS_ELF = HelloOS.elf
HELLOOS_BIN = HelloOS.bin

# .PHONY 定义伪目标，这里定义了五个伪目标
.PHONY : build clean all link bin

# 伪目标 all 依赖于后面四个伪目标
all: clean build link bin

# 定义伪目标 clean 的规则，强制清除 .o .bin .elf 结尾的文件
clean:
	$(RM) -f *.o *.bin *.elf

# 定义伪目标 build 的规则，构建
build: $(HELLOOS_OBJS)

# 定义伪目标 build 的规则，链接
link: $(HELLOOS_ELF)
$(HELLOOS_ELF): $(HELLOOS_OBJS)
	$(LD) $(LDFLAGS) -o $@ $(HELLOOS_OBJS)
bin: $(HELLOOS_BIN)
$(HELLOOS_BIN): $(HELLOOS_ELF)
	$(OBJCOPY) $(OJCYFLAGS) $< $@

# 所有 .o 结尾的文件依赖于所有 .asm 的文件
# 并执行通用规则：nasm -f elf -w-orphan-labels -o xxx.o xxx.asm
%.o : %.asm
	$(ASM) $(ASMBFLAGS) -o $@ $<

# 所有 .o 结尾的文件依赖于所有 .c 的文件
# 并执行通用规则：
# gcc -c -Os -std=c99 -m32 -Wall -Wshadow -W -Wconversion -Wno-sign-conversion  -fno-stack-protector -fomit-frame-pointer -fno-builtin -fno-common  -ffreestanding  -Wno-unused-parameter -Wunused-variable -o xxx.o xxx.c
%.o : %.c
	$(CC) $(CFLAGS) -o $@ $<