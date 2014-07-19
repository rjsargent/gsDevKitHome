#=========================================================================
# Copyright (c) 2014 GemTalk Systems, LLC <dhenrich@gemtalksystems.com>.
#
# Name - stones.sh
#
# Purpose - Provide information about the installed and running stones
#
# Examples
#   stones.sh --help
#   stones.sh
#
#=========================================================================

if [ "${GS_HOME}x" = "x" ] ; then
  echo "the GS_HOME environment variable needs to be defined"
  exit 1
fi
if [ ! -e "$GS_HOME/pharo/pharo" ]; then
  $GS_HOME/bin/installPharo.sh
fi

# Run script
pharo=$GS_HOME/pharo
$pharo/pharo $pharo/todeClient.image stones $*

# End of script
exit 0