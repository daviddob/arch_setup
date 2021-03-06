# -*- coding: utf-8 -*-
"""
Display currently playing song from Google Play Music Desktop Player.

Configuration parameters:
    cache_timeout:  how often we refresh this module in seconds (default 5)
    format:         specify the items and ordering of the data in the status bar.
                    These area 1:1 match to gpmdp-remote's options (default is '♫ {info}').

Format of status string placeholders:
    See `gpmdp-remote help`. Simply surround the items you want displayed (i.e. `album`)
    with curly braces (i.e. `{album}`) and place as-desired in the format string.

    {info}            Print info about now playing song
    {title}           Print current song title
    {artist}          Print current song artist
    {album}           Print current song album
    {album_art}       Print current song album art URL
    {time_current}    Print current song time in milliseconds
    {time_total}      Print total song time in milliseconds
    {status}          Print whether GPMDP is paused or playing
    {current}         Print now playing song in "artist - song" format
    {help}            Print this help message


Requires:
    gpmdp: http://www.googleplaymusicdesktopplayer.com/
    gpmdp-remote: https://github.com/iandrewt/gpmdp-remote

@author Aaron Fields https://twitter.com/spirotot
@license BSD
"""

from time import time
from subprocess import check_output


class Py3status:
    """
    """
    # available configuration parameters
    cache_timeout = 5
    format = u'♫ {title} - {artist}'

    @staticmethod
    def _run_cmd(cmd):
        return check_output(['gpmdp-remote', cmd]).decode('utf-8').strip()

    def gpmdp(self, i3s_output_list, i3s_config):
        if self._run_cmd('status') == 'Paused':
            result = ''
        else:
            cmds = ['info', 'title', 'artist', 'album', 'status', 'current',
                    'time_total', 'time_current', 'album_art']
            data = {}
            for cmd in cmds:
                if '{%s}' % cmd in self.format:
                    data[cmd] = self._run_cmd(cmd)

            result = self.format.format(**data)

        response = {
            'cached_until': time() + self.cache_timeout,
            'full_text': result
        }
        return response


if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test
    module_test(Py3status)
