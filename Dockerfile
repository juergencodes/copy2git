FROM docker:25.0.5-git

RUN mkdir /repo
COPY root/label.sh /
COPY root/run.sh /
COPY root/copy2git.sh /etc/periodic/hourly

RUN git config --global credential.helper store
RUN git config --global user.name "docker"
RUN git config --global user.email docker@localhost

COPY root/.git-credentials /root

ENTRYPOINT crond -l 2 -f