from .agent_based_api.v1 import *
import pprint

def discover_wg_active_sessions(section):
    for interface, _count in section:
        yield Service(item=interface)

def check_wg_active_sessions(item,section):
    for interface, count in section:
        if interface == item:
            count = int(count)
            if count >= 10:
                s = State.CRIT
            elif count >= 8:
                s = State.WARN
            else:
                s = State.OK
            yield Metric("Sessions",count)
            yield Result(
                state = s,
                summary = f"{count} sessions active")
            return

register.check_plugin(
    name="wg_active_sessions",
    service_name="VPN Sessions: %s",
    discovery_function=discover_wg_active_sessions,
    check_function=check_wg_active_sessions,
)
