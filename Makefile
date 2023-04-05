#
# Compile and install the firmware files to /lib/firmware tree
# Requires the alsatplg tool (alsa-utils)
#

SRCPATH ?= .
FWPATH ?= $(DESTDIR)/lib/firmware

builddir = buildd

targets = $(builddir)/skl_hda_dsp_generic-tplg.bin

all: $(targets)

$(builddir)/skl_hda_dsp_generic-tplg.bin: $(SRCPATH)/topology/hda-dsp/skl_hda_dsp_generic-tplg.conf

$(targets):
	test -d "$(dir $@))" || mkdir -p "$(dir $@})"
	alsatplg -c $< -o $@

install: $(targets)
	for t in $(targets) ; do \
		install -Dm644 "$${t}" "$(FWPATH)/$${t#$(builddir)/}" ; \
	done

clean:
	rm -rf "$(builddir)"

.PHONY: all install clean
