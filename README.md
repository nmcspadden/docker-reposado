# docker-reposado
Docker container for reposado

To use this container:
---

Make a data-only container:  
`docker run -d --name reposado-data --entrypoint /bin/echo nmcspadden/reposado Data-only container for reposado`

Configure preferences.plist with any custom settings you want.  See the [Reposado documentation](https://github.com/wdas/reposado/blob/master/docs/reposado_preferences.txt) for details.

Run the container itself:  
`docker run -d --name reposado --volumes-from reposado-data -p 8080:8080 -h reposado nmcspadden/reposado`

If you want to pass in a custom preferences.plist:  
`docker run -d --name reposado --volumes-from reposado-data -p 8080:8080 -h reposado -v preferences.plist:/reposado/code/preferences.plist nmcspadden/reposado`

To sync the repo:  
`docker exec reposado python /reposado/code/repo_sync`

See the [Reposado documentation](https://github.com/wdas/reposado/blob/master/docs/reference.txt) for reference on how to use `repoutil`, but all commands will be:  
`docker exec reposado python /reposado/code/repoutil <arguments>`