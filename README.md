# nginx-ajp-docker
While pentesting I stumbled upon an open AJP proxy on port 8009. Hacktricks includes notes on how to build an nginx server and use it as an http proxy to access internal servers exposed by AJP


## Nginx Reverse Proxy & AJP

- Download the Nginx source code
- Download the required module
- Compile Nginx source code with the `ajp_module`
- Create a configuration file pointing to the AJP Port
