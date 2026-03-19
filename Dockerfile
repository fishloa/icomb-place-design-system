FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY verdant-tokens.css   /usr/share/nginx/html/
COPY verdant-base.css     /usr/share/nginx/html/
COPY verdant-tailwind.css /usr/share/nginx/html/
COPY verdant-tokens.css   /usr/share/nginx/html/
COPY verdant-spec.md      /usr/share/nginx/html/
COPY verdant-readme.md    /usr/share/nginx/html/
COPY index.html           /usr/share/nginx/html/

EXPOSE 80
