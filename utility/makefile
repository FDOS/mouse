# Macros for building, deleting ########################################

AS=tasm -m @..\asmlib.cfg
LINKEXE=tlink /x
LINKCOM=tlink /x /t

RM=del


# Rules to build files #################################################

.asm.obj:
	$(AS) $*
.obj.com:
	$(LINKCOM) $*
.obj.exe:
	$(LINKEXE) $*


# Targets ##############################################################

all: comtest.com protocol.com wheeltst.com

comtest.com: comtest.obj

protocol.com: protocol.obj

wheeltst.com: wheeltst.obj

comtest.obj: comtest.asm ..\asmlib\*.* ..\asmlib\bios\area0.def \
		..\asmlib\convert\digit.mac ..\asmlib\convert\count2x.inc \
		..\asmlib\dos\io.mac ..\asmlib\dos\mem.mac \
		..\asmlib\hard\pic8259a.def ..\asmlib\hard\uart.def

protocol.obj: protocol.asm ..\asmlib\*.* ..\asmlib\bios\area0.def \
		..\asmlib\convert\digit.mac ..\asmlib\convert\count2x.inc \
		..\asmlib\dos\io.mac ..\asmlib\dos\mem.mac \
		..\asmlib\hard\pic8259a.def ..\asmlib\hard\uart.def

wheeltst.obj: wheeltst.asm


# Clean up #############################################################

clean:
	-$(RM) *.obj
