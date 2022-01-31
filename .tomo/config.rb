# rubocop:disable Style/FormatStringToken
plugin "git"
plugin "env"
plugin "bundler"
plugin "rails"
# plugin "nodenv"
plugin "puma"
plugin "rbenv"
plugin "./plugins/nginx.rb"

host "dinner_deployer@rpi4"

set application: "dinner"
set deploy_to: "/var/www/%{application}"
# set nodenv_node_version: "16.13.1"
# set nodenv_install_yarn: true
set git_url: "git@github.com:bweave/dinner"
set git_branch: "main"
set git_exclusions: %w[
  .tomo/
  spec/
  test/
]
set env_vars: {
  RACK_ENV: "production",
  RAILS_ENV: "production",
  RAILS_LOG_TO_STDOUT: "1",
  RAILS_SERVE_STATIC_FILES: "1",
  BOOTSNAP_CACHE_DIR: "tmp/bootsnap-cache",
  DATABASE_URL: :prompt,
  SECRET_KEY_BASE: :prompt
}
set linked_dirs: %w[
  log
  public/assets
  public/packs
  tmp/cache
  tmp/pids
  tmp/sockets
]
# .yarn/cache
# node_modules

setup do
  run "env:setup"
  run "core:setup_directories"
  run "git:clone"
  run "git:create_release"
  run "core:symlink_shared"
  # run "nodenv:install"
  run "rbenv:install"
  run "bundler:upgrade_bundler"
  run "bundler:config"
  run "bundler:install"
  run "rails:db_create"
  run "rails:db_schema_load"
  run "rails:db_seed"
  run "puma:setup_systemd"
  run "nginx:configure"
end

deploy do
  run "env:update"
  run "git:create_release"
  run "core:symlink_shared"
  run "core:write_release_json"
  run "bundler:install"
  run "rails:db_migrate"
  run "rails:db_seed"
  run "rails:assets_precompile"
  run "core:symlink_current"
  run "puma:restart"
  run "puma:check_active"
  run "core:clean_releases"
  run "bundler:clean"
  run "core:log_revision"
end
# rubocop:enable Style/FormatStringToken
