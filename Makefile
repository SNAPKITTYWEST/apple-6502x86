# Apple 6502x86 Hybrid Stack — Build System
# Requires NASM >= 2.15

ASM = nasm
ASMFLAGS = -f elf64 -g -F dwarf

MODULES = \
	boot/boot.o \
	boot/boot_diag.o \
	rom/rom.o \
	rom/rom_diag.o \
	monitor/monitor.o \
	monitor/monitor_diag.o \
	memory/memory.o \
	memory/memory_diag.o \
	cpu/cpu.o \
	neural/neural.o \
	toolbox/toolbox.o \
	scheduler/scheduler.o \
	diagnostics/diagnostics.o \
	graphics/graphics.o \
	dylan/dylan_runtime.o \
	tests/tests.o \
	firmware/firmware.o

.PHONY: all clean test count

all: $(MODULES)
	@echo "All modules assembled."
	@echo "Total object files: $(words $(MODULES))"

%.o: %.asm
	$(ASM) $(ASMFLAGS) $< -o $@

test: all
	@echo "Running test suite..."
	nasm -f elf64 tests/tests.asm -o tests/tests.o

count:
	@wc -l **/*.asm | tail -1

clean:
	find . -name "*.o" -delete
	@echo "Clean."
