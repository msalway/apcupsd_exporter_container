
NAME := apcupsd-exporter
VERSION := 0.3.0
TAG := $(VERSION).$(shell dirhash)
BUILDARGS := --arch arm64

include Makefile.generic
