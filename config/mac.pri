###############
# Any of the following may be overriden by the environment
###############

# Wether to build static, plugin or shared library
#ROXEE_LINK_TYPE = static
ROXEE_LINK_TYPE = dynamic
# XXX unlikely to work presently ROXEE_LINK_TYPE = plugin

# You can choose to link against the third-party provided libraries.
# If so, this should be not null and point to a specific version and subpath
ROXEE_INTERNAL_VERSION = stable#head
ROXEE_INTERNAL_PATH = sparkler-mac

# If you rather want to link against your own, specify ROXEE_EXTERNAL, a directory that must contain include and lib folders with the necessary dependencies
# Note this will be used BEFORE any other manually specified source
#ROXEE_EXTERNAL = /Users/dmp/buildd/deploy.webitup.org/client/Darwin/debug/static
ROXEE_EXTERNAL =

# Not specifying either means your third-party are already installed system-wide.

# Where to output the final build (will default to buildd/$$platform/$$compiler-$$qtmajorversion-$$linktype-$$buildtype) if left empty
ROXEE_DESTDIR =

# Flags to use in order to link to the third-party (lib only)
ROXEE_LIBS = -framework Sparkle -framework AppKit
# Special include paths (appended to external deps, if any)  (lib only)
ROXEE_INC = Frameworks/Sparkle.framework/Headers
