2. 

J'ai initialiser un project Next car je prefere 

npx create-next-app@latest maxence-tp3

3. 

npm run dev

4.

Etape 1 :

FROM node:18-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install --frozen-lockfile

COPY . .
RUN npm run build

Etape 2 :

FROM nginx:alpine

COPY --from=builder /app/.next /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

5. 

docker build -t maxence-tp3 .

docker run -p 8080:80 maxence-tp3

Resultat : 172.17.0.1 - - [06/Feb/2025:13:34:22 +0000] "GET / HTTP/1.1" 200 615