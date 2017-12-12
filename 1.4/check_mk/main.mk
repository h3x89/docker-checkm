# Put your host names here
# all_hosts = [ 'localhost' ]
all_hosts = [ ]
agent_ports = [ ]

_client_NAME = "test123"
_client_IP = "172.17.0.1"
_client_PORT = 6556
_client_TAGS = "|LINUX|NAGIOS|SECRET-MERIDIAN-680"
_client_GROUPS = "|ALL|NAGIOS"

_client_NAME_PORT_TAGS =  str(str(_client_NAME) + "|" + str(_client_PORT) + str(_client_TAGS) + str(_client_GROUPS))

all_hosts  += [ _client_NAME_PORT_TAGS ]
ipaddresses.update({ _client_NAME : _client_IP })
agent_ports += [( _client_PORT, [ str(_client_PORT) ], all_hosts )]
