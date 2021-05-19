from .agent_based_api.v1 import *
import pprint

# /omd/sites/<SITE>/local/lib/check_mk/base/plugins/agent_based

def discover_fail2ban_banned(section):
    for jail, _count in section:
        yield Service(item=jail)

def check_fail2ban_banned(item,section):
    for jail, count in section:
        if jail == item:
            count = int(count)
            if count >= 300:
                s = State.CRIT
            elif count >= 250:
                s = State.WARN
            else:
                s = State.OK
            yield Metric("Banned",count)
            yield Result(
                state = s,
                summary = f"{count} IPs banned")
            return

register.check_plugin(
    name="fail2ban_banned",
    service_name="fail2ban JAIL: %s",
    discovery_function=discover_fail2ban_banned,
    check_function=check_fail2ban_banned,
)
