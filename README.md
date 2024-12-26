# Content

Run an export command in other containers, copy files and commit to git.

# Configuration

Add labels to your containers, e.g.
```
docker run \ 
  -it \ 
  --rm \
  --label copy2git.active=true \
  --label copy2git.repo=http://git.myserver.de/myorg/myrepo.git \
  --label "copy2git.command=touch /x.txt" \
  --label copy2git.file1.from=/x.txt \
  --label copy2git.file1.to=.run/x.txt \
  alpine /bin/sh
```

or in docker compose
```
    labels:
      - "copy2git.active=true"
      - "copy2git.repo=http://git.myserver.de/myorg/myrepo.git"
      - "copy2git.command=./export.sh"
      - "copy2git.file1.from=/export1.json"
      - "copy2git.file1.to=root/export1.json"
      - "copy2git.file2.from=/export2.json"
      - "copy2git.file2.to=root/export2.json"
```

# Usage

Start
```
docker-compose up -d --build
```

Hint: Don't forget to bind docker sock as volume:
```
/var/run/docker.sock:/var/run/docker.sock
```