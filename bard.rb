server :production do
  ssh "www@riverwest24.com:22022"
end

data "public/userfiles", "storage"
