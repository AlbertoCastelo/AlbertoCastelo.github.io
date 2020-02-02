docker rm -f blog

docker build -t jekyll-blog .

# docker run -d -v /webroot:/var/www/html -p 4000:4000 --name blog jekyll-blog 
docker run -it -p 4000:4000 --name blog -v "$PWD":/srv/jekyll jekyll-blog 