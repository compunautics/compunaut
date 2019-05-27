#!/bin/bash

gitlab-rails r 'token = PersonalAccessToken.new(user: User.where(id: 1).first, name: "saltstack_token", token: "{{ saltstack_token }}", scopes: Gitlab::Auth::available_scopes); token.save!'
