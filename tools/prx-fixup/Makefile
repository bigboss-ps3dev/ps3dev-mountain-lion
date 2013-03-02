TARGET		:= ppu-lv2-prx-fixup
SOURCE		:= .
INCLUDE		:= .

CFLAGS		:= -O2 -Wall --std=gnu99 -I/opt/local/include/libelf -I/opt/local/include 
LDFLAGS		:= -lelf -L/opt/local/lib 

CC		:= gcc

CFILES		:= ppu-lv2-prx-fixup.c
#INCLUDES	:= $(foreach dir,$(INCLUDE),-I$(dir))

all: $(TARGET)

install: all
	@echo Installing $(TARGET)
	@[ -d $(PS3DEV)/bin ] || mkdir -p $(PS3DEV)/bin
	@install -m 755 $(TARGET) $(PS3DEV)/bin

clean:
	@echo clean ...
	@rm -rf $(TARGET)

$(TARGET): $(CFILES)
			@echo building ... $(notdir $@)
			@$(CC) $(CFLAGS) $(INCLUDES) $< -o $@ $(LDFLAGS)

