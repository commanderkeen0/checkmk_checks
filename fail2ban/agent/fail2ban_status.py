from .agent_based_api.v1 import *
import pprint

# /omd/sites/<SITE>/local/lib/check_mk/base/plugins/agent_based

def discover_fail2ban_status(section):
    yield Service()

def check_fail2ban_status(section):
    for line in section:
        if line[0].startswith("active-running"):
            s = State.OK
            message = "Service ok"
            yield Metric("Status",1)
        else:
            s = State.CRIT
            message = "Service error"
            yield Metric("Status",0)

        yield Result(
            state = s,
            summary = message)
        return

register.check_plugin(
    name="fail2ban_status",
    service_name="fail2ban service status:",
    discovery_function=discover_fail2ban_status,
    check_function=check_fail2ban_status,
)
