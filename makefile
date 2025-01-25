# ----------------------------
# Makefile Options
# ----------------------------

NAME ?= OIRAM
ICON ?= iconc.png
DESCRIPTION ?= "Oiram"
COMPRESSED ?= NO
ARCHIVED ?= NO

CFLAGS ?= -Wall -Wextra -Oz
CXXFLAGS ?= -Wall -Wextra -Oz

# ----------------------------

include $(shell cedev-config --makefile)
