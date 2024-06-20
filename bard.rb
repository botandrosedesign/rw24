server :production do
  ssh "www@ssh.riverwest24.com:22022"
  ping "riverwest24.com"
end

data "public/userfiles", "storage"
