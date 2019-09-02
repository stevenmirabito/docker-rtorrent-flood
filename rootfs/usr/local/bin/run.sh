#!/bin/sh

mkdir -p /data/torrents
mkdir -p /data/.watch
mkdir -p /data/.session

rm -f /data/.session/rtorrent.lock

chown -R $UID:$GID /data /home/torrent /tmp /usr/flood/dist /flood-db /etc/s6.d
htpasswd -c -b /etc/nginx/auth.htpasswd $XMLRPC_USER $XMLRPC_PASSWORD

if [ ${RTORRENT_SOCK} = "false" ]; then
    sed -i -e 's|^network.scgi.open_local.*$|network.scgi.open_port = 0.0.0.0:'${RTORRENT_SCGI}'|' /home/torrent/.rtorrent.rc
fi

exec /bin/s6-svscan /etc/s6.d
