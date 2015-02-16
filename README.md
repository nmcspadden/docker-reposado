# docker-reposado
Docker container for [Reposado](https://github.com/wdas/reposado/).

To run this container:
====

Make a data-only container:  
`docker run -d --name reposado-data --entrypoint /bin/echo nmcspadden/reposado Data-only container for reposado`

Configure preferences.plist with any custom settings you want.  See the [Reposado documentation](https://github.com/wdas/reposado/blob/master/docs/reposado_preferences.txt) for details.

Run the container itself:  
`docker run -d --name reposado --volumes-from reposado-data -h reposado nmcspadden/reposado`

If you want to pass in a custom preferences.plist:  
`docker run -d --name reposado --volumes-from reposado-data -h reposado -v preferences.plist:/reposado/code/preferences.plist nmcspadden/reposado`

If you want to map to a port other than port 80 (if, for example, you're already running [Munki](https://registry.hub.docker.com/u/nmcspadden/munki/) on port 80), use the `-p` option.  This will map reposado to port 8080 on the host instead:  
`docker run -d --name reposado --volumes-from reposado-data -p 8080:80 -h reposado nmcspadden/reposado`

Using Reposado:
===

[Configuring a client](https://github.com/wdas/reposado/blob/master/docs/client_configuration.txt) can be done with:  
`defaults write com.apple.SoftwareUpdate CatalogURL http://docker_ip/content/catalogs/<catalogURL>`  
where `docker_ip` is the IP address of your Docker host, and `<catalogURL>` is one of the available catalogs.

This container includes automatic URL rewrites for "/index.sucatalog".  You can simplify client configuration by pointing all clients to that central index:  
`defaults write com.apple.SoftwareUpdate CatalogURL http://docker_ip/index.sucatalog`

From the [Reposado URL rewrite documentation:](https://github.com/wdas/reposado/blob/master/docs/URL_rewrites.txt), you can test out the URL rewrites using `curl`:  
`curl --user-agent "Darwin/11.4.0" http://docker_ip:8080/content/catalogs/index.sucatalog > /tmp/testing`  
where `docker_ip` is the IP address of your Docker host.

Then, check the catalog you downloaded to see the CatalogName key:  
`$ tail -5 /tmp/testing`  
```	</dict>  
	<key>_CatalogName</key>  
	<string>index-lion-snowleopard-leopard.merged-1_testing.sucatalog</string>  
</dict>  
</plist>
```

To sync the repo:  
`docker exec reposado python /reposado/code/repo_sync`

See the [Reposado documentation](https://github.com/wdas/reposado/blob/master/docs/reference.txt) for reference on how to use `repoutil`, but all commands will be:  
`docker exec reposado python /reposado/code/repoutil <arguments>`
