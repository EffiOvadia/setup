#\find ~ -type f -exec chmod 600 {} \;
#\find ~ -type d -exec chmod 700 {} \;

#\find ~ -type f -print0 | xargs -0 chmod 600
#\find ~ -type d -print0 | xargs -0 chmod 700