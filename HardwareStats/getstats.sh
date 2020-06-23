#!/bin/sh

#  getstats.sh
#  HardwareStats
#
#  Created by Futaba Dev on 27.05.2020.
#  Copyright © 2020 Futaba Dev. All rights reserved.

ioreg -l |grep \"PerformanceStatistics\" | cut -d '{' -f 2 | tr '|' ',' | tr -d '}' | tr ',' '\n'|grep 'Temp\|Fan\|Clock';
