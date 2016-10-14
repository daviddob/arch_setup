# -*- coding: utf-8 -*-
"""
Dummy py3status file so an icon with on_click events can be added to the bar
"""


class Py3status:
    format = 'monitor'
    def monitor(self):
        return {
            'full_text': self.format,
            'cached_until': self.py3.CACHE_FOREVER
        }
