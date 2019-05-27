#!/bin/bash

gitlab-rails r 'token = PersonalAccessToken.new(user: User.where(id: 1).first, name: "saltstack_token", token: "{{ saltstack_token }}", scopes: Gitlab::Auth::available_scopes); token.save!'

gitlab-rails r 'token_digest = Gitlab::CryptoHelper.sha256 "{{ saltstack_token }}"; token = PersonalAccessToken.create!(name: "saltstack_token", scopes: Gitlab::Auth::all_available_scopes, user: User.where(id: 1).first, token_digest: token_digest); token.save!'
