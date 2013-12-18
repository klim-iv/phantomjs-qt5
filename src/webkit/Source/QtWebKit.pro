# -------------------------------------------------------------------
# Root project file for QtWebKit
#
# See 'Tools/qmake/README' for an overview of the build system
# -------------------------------------------------------------------

TEMPLATE = subdirs
CONFIG += ordered

api.file = api.pri
SUBDIRS += api

build?(webkit1) {
    webkitwidgets.file = widgetsapi.pri
    SUBDIRS += webkitwidgets
}

build?(webkit2) {
    webprocess.file = WebKit2/WebProcess.pro
    SUBDIRS += webprocess
    enable?(PLUGIN_PROCESS) {
        pluginprocess.file = WebKit2/PluginProcess.pro
        SUBDIRS += pluginprocess
    }

    enable?(SUID_SANDBOX_LINUX) {
        sandboxprocess.file = WebKit2/SandboxProcess.pro
        SUBDIRS += sandboxprocess
    }
}

declarative.file = WebKit/qt/declarative/declarative.pro
declarative.makefile = Makefile.declarative
have?(QTQUICK): SUBDIRS += declarative