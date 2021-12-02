FROM gitpod/workspace-full

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN echo "dockerfile version 2021.10.26-12:25"

RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb

RUN apt-get update \
    && apt-get install esl-erlang -y \
    && apt-get install elixir -y \
    && apt-get install inotify-tools -y \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

USER gitpod

RUN mix local.hex --force \
    && mix local.rebar --force

# Allow gitpod group to edit 
RUN sudo chown -R root:gitpod /home/gitpod/.mix \
    && sudo chmod -R g+rw /home/gitpod/.mix
