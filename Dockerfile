FROM nginx:stable

# Static site content (built from this repo)
COPY site/ /usr/share/nginx/html/

