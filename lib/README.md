# Namespacing

Files in the lib directory must be namespaced with the filename as a prefix for all modules and functions. This keeps files' modules and functions from colliding.  Private modules and functions should be prefixed with _ and with the filename to prevent collisions.

# Constants

Constants which can be reused by various module files are stoerd in the constants directory.  They are prefixed with the filename and exports only variables.  These are for things such as metric screw dimensions, part dimensions, etc.