server :production do
  ssh "www@ssh.riverwest24.com:22022"
end

data "public/userfiles", "storage"
