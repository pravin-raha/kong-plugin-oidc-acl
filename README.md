# kong-plugin-oidc-acl
Restrict access to a Service or a Route by whitelisting or blacklisting user using arbitrary ACL role names. This plugin requires an [oidc](https://github.com/nokia/kong-oidc) plugin to have been already enabled on the Service or Route. This plugin is specifically build for [keycloak](https://www.keycloak.org/) 

## Install

Install luarocks and run the following command

```bash
luarocks install kong-plugin-oidc-acl
```
You also need to set the KONG_PLUGINS environment variable

```bash
export KONG_PLUGINS=bundled,oidc-acl
```

## Configuration

To enable the plugin only for one service:

```bash
curl -X POST http://localhost:8001/services/{ID}/plugins \
    --data "name=oidc-acl"  \
    --data "config.whitelist=admin" \
    --data "config.whitelist=user"
```

| Form Parameter         | Default    | Required        | Description                                                                                                                         |
|------------------------|------------|-----------------|-------------------------------------------------------------------------------------------------------------------------------------|
| `userinfo_header_name` | x-userinfo | *optional*      | The name of the HTTP header from where role names is going to be extracted. This should be same as what you have set in oidc plugin |
| `whitelist`            |            | *semi-optional* | The name of the role to allow                                                                                                       |
| `blacklist`            |            | *semi-optional* | The name of the role to not allow                                                                                                   |


## License

Copyright 2022 Pravin Rahangdale

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.