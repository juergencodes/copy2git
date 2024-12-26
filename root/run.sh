#!/bin/sh

docker container ls --format "{{.Names}}" | while read -r c; do
    active=$(/label.sh $c active)
    if [ ! -z "$active" ];
    then
        target=/repo/$c
        if [ ! -d "$target" ];
        then
            repo=$(/label.sh $c repo)
            echo "cloning $repo into $target"
            git clone $repo $target
        else
            echo "Target folder $target already exists. Assuming correct repo checked out."
        fi
        command=$(/label.sh $c command)
        if [ ! -z "$command" ];
        then
            echo "Executing '$command' in container '$c'"
            docker exec $c /bin/sh -c "$command"
        else
            echo "Skipping command, because no command given"
        fi
        for i in `seq 1 10`
        do
            from=$(/label.sh $c file$i.from)
            to=$(/label.sh $c file$i.to)
            if [ ! -z "$from" ];
            then
                echo exporting $from to $target/$to
                docker cp $c:$from $target/$to
            fi
        done
        git -C $target pull
        git -C $target add .
        git -C $target commit -m 'automatic copy from docker'
        git -C $target push
    fi
done