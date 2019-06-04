gitlab.repo:
  pkgrepo.managed:
    - name: deb https://packages.gitlab.com/gitlab/gitlab-ce/ubuntu/ xenial main
    - dist: xenial
    - file: /etc/apt/sources.list.d/gitlab_gitlab-ce.list
    - keyid: E15E78F4
    - keyserver: keyserver.ubuntu.com
