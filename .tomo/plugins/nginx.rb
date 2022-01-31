def configure
  nginx_conf = "#{settings[:application]}.nginx.conf"
  nginx_conf_path = "#{paths.shared}/#{nginx_conf}"
  remote.write template: File.expand_path("../templates/nginx.erb", __dir__), to: nginx_conf_path
  logger.info <<~INFO
    Remember to enable this site:
      sudo ln -s #{nginx_conf_path} /etc/nginx/sites-available/#{nginx_conf}
      sudo ln -s /etc/nginx/sites-available/#{nginx_conf} /etc/nginx/sites-enabled/#{nginx_conf}
  INFO
end

def status
  remote.run "sudo service nginx status"
end