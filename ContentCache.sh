#!/bin/zsh
########################################################################
# Metadata allows your plugin to show up in the app, and website.
#
#  <xbar.title>MacOS Content Caching Status</xbar.title>
#  <xbar.version>v1.0</xbar.version>
#  <xbar.author>xerox914</xbar.author>
#  <xbar.author.github>xerox914</xbar.author.github>
#  <xbar.desc>Provides status of MacOS content cache if enabled of cached software in System Preferences / Sharing / Content Caching</xbar.desc>
#  <xbar.image></xbar.image>
#  <xbar.dependencies>zsh</xbar.dependencies>
#  <xbar.abouturl>https://github.com/xerox914/xbar-contentCacheStatus/blob/main/README.md</xbar.abouturl>
########################################################################
/usr/bin/AssetCacheManagerUtil status > /tmp/asset.cache.util 2>&1
########################################################################
extract() {
   CMD="/usr/bin/fgrep '$1' /tmp/asset.cache.util | /usr/bin/sed 's/^[ \t]*//'"
   eval "$CMD"
}
########################################################################
LIMIT=`/usr/bin/fgrep '    CacheLimit:' /tmp/asset.cache.util | sed 's/.*: //' | /usr/bin/sed 's/^[ \t]*//'`
ACTIVATED=`/usr/bin/fgrep '    Active: true' /tmp/asset.cache.util`
STATUS="disabled"
ICON="􀃂"
if [[ $ACTIVATED == *true* ]]; then
    STATUS="enabled"
    ICON="􀃲"
fi
########################################################################
echo "􀶉"
echo "---"
########################################################################
########################################################################
echo "CONTENT CACHE STATUS"
echo "---"
echo "$ICON  $LIMIT $STATUS"
########################################################################
echo "---"
########################################################################
extract '    CacheLimit:'
extract '    CacheFree:'
echo "---"
extract '    CacheUsed:'
########################################################################
echo -n '▪ '; extract 'iOS Software:'
echo -n '▪ '; extract 'Mac Software:'
echo -n '▪ '; extract '        Other:'
########################################################################



